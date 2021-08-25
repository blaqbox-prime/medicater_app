import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medicater_app/constants.dart';
import 'package:medicater_app/models/order.dart';
import 'package:medicater_app/providers/orderProvider.dart';
import 'package:medicater_app/providers/sellerProvider.dart';
import 'package:medicater_app/screens/common/OrderSummary.dart';
import 'package:medicater_app/screens/common/w_Title.dart';
import 'package:medicater_app/services/mysql_service.dart';
import 'package:provider/provider.dart';

class S_OrdersScreen extends StatefulWidget {
  S_OrdersScreen({Key? key}) : super(key: key);

  @override
  _S_OrdersScreenState createState() => _S_OrdersScreenState();
}

class _S_OrdersScreenState extends State<S_OrdersScreen> {
  final db = MysqlService();
  var allOrders;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final pharmacy = Provider.of<SellerProvider>(context, listen: false);
    allOrders = db.fetchOrders(pharmacy.id!);
  }

  @override
  Widget build(BuildContext context) {
    final pharmacy = Provider.of<SellerProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenTitle(text1: "Order", text2: "\nHistory"),
                SizedBox(height: 10),
                FutureBuilder(
                    future: allOrders,
                    builder: (ctx, snapshot) {
                      if (snapshot.hasData) {
                        return _SellerOrdersList(
                            context: context,
                            orders: snapshot.data as List<Order>);
                      }
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return Center(
                          child:
                              Text("Failed to load Orders ${snapshot.error}"),
                        );
                      }
                      return Container(
                        child: Center(
                          child: Column(
                            children: [
                              CircularProgressIndicator(),
                              Text("Loading Orders")
                            ],
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _SellerOrdersList({required List<Order> orders, context}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: ListView.builder(
          itemCount: orders.length,
          shrinkWrap: true,
          itemBuilder: (context, idx) {
            Order order = orders[idx];
            order.pharmacy =
                Provider.of<SellerProvider>(context, listen: false).pharmacy;
            return ListTile(
              onTap: () async {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (ctx) => OrderSummary(
                              order: order,
                              viewer: "seller",
                            )))
                    .then((value) => setState(() => {}));
              },
              title: Text(order.customer!.fullname),
              trailing: Icon(
                Icons.circle,
                color: order.statusClr(),
              ),
              subtitle: Row(
                children: [
                  Text("${order.orderStatus} - ${order.order_time}"),
                  SizedBox(width: 15),
                ],
              ),
            );
          }),
    );
  }

  _buildOrdersList({required List<Order> orders}) {
    return ListView.builder(
        itemCount: orders.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Provider.of<OrderProvider>(context, listen: false).order =
                  orders[index];
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      OrderSummary(order: orders[index], viewer: "seller")));
            },
            child: Container(
              height: 80,
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: Icon(
                      Icons.person,
                      size: 20,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        orders[index].customer!.fullname,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ), //Name of customer
                      Text(orders[index].orderStatus!,
                          style: TextStyle(
                            color: orders[index].statusClr(),
                          )), //Status of current order
                    ],
                  ),
                  Spacer(),
                  RichText(
                    text: TextSpan(
                        text: orders[index].order_date,
                        style: TextStyle(fontSize: 12, color: text_color),
                        children: [
                          TextSpan(
                            text: "\n${orders[index].order_time}",
                            style: TextStyle(fontSize: 12),
                          )
                        ]),
                    textAlign: TextAlign.right,
                    softWrap: true,
                  )
                ],
              ),
            ),
          );
        });
  }

  _buildNewOrdersList(BuildContext context) {
    return FutureBuilder(
        future: allOrders,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/images/undraw_access_denied.svg",
                  height: 150,
                  alignment: Alignment.center,
                ),
                Text("Failed to load products."),
              ],
            );
          }

          if (snapshot.hasData) {
            return _buildOrdersList(orders: snapshot.data as List<Order>);
          }

          return Center(
            child: Column(
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 20,
                ),
                Text("Loading Orders...")
              ],
            ),
          );
        });
  }

  _buildOngoingOrdersList(BuildContext context, String pharm_id) {
    return FutureBuilder(
        future: db.getOngoingOrders(pharm_id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            _buildOrdersList(orders: snapshot.data as List<Order>);
          }

          return Center(
            child: Text("No data available"),
          );
        });
  }

  _buildCancelledOrdersList(BuildContext context, String pharm_id) {
    return FutureBuilder(
        future: db.getCancelledOrders(pharm_id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            return _buildOrdersList(orders: snapshot.data as List<Order>);
          }
          return Center(
            child: Text("No data available"),
          );
        });
  }

  _buildCompletedOrdersList(BuildContext context, String pharm_id) {
    return FutureBuilder(
        future: db.getCompletedOrders(pharm_id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            _buildOrdersList(orders: snapshot.data as List<Order>);
          }

          return Center(
            child: Text("No data available"),
          );
        });
  }
}
