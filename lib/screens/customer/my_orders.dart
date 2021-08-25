import 'package:flutter/material.dart';
import 'package:medicater_app/models/order.dart';
import 'package:medicater_app/providers/accountProvider.dart';
import 'package:medicater_app/screens/common/OrderSummary.dart';
import 'package:medicater_app/screens/common/w_Title.dart';
import 'package:medicater_app/screens/customer/nav_bar.dart';
import 'package:medicater_app/services/mysql_service.dart';
import 'package:provider/provider.dart';

class MyOrders extends StatefulWidget {
  MyOrders({Key? key}) : super(key: key);

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  final db = MysqlService();
  var allOrders;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final user =
        Provider.of<AccountProvider>(context, listen: false).customerDetails;
    allOrders = db.getUserOrders(user.custId!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenTitle(text1: "My", text2: "\nOrders"),
                SizedBox(height: 10),
                FutureBuilder(
                    future: allOrders,
                    builder: (ctx, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data == []) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Create your first order today'),
                              OutlinedButton(
                                  onPressed: () => {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (ctx) => PageCtrl(
                                                      screenIndex: 0,
                                                    )))
                                      },
                                  child: Text('Go Shopping'))
                            ],
                          );
                        }
                        return _UserOrdersList(
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

  Widget _UserOrdersList({required List<Order> orders, context}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: ListView.builder(
          itemCount: orders.length,
          shrinkWrap: true,
          itemBuilder: (context, idx) {
            Order order = orders[idx];
            return ListTile(
              onTap: () async {
                await order.setOrderItems();
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (ctx) => OrderSummary(
                              order: order,
                              viewer: "customer",
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
}
