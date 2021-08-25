import 'package:flutter/material.dart';
import 'package:medicater_app/constants.dart';
import 'package:medicater_app/models/address.dart';
import 'package:medicater_app/models/customer.dart';
import 'package:medicater_app/models/order.dart';
import 'package:medicater_app/models/pharmacy.dart';
import 'package:medicater_app/providers/sellerProvider.dart';
import 'package:medicater_app/screens/common/w_Title.dart';
import 'package:medicater_app/services/mysql_service.dart';
import 'package:provider/provider.dart';
import '../../providers/accountProvider.dart';

class SellerDash extends StatefulWidget {
  SellerDash({Key? key}) : super(key: key);

  @override
  _SellerDashState createState() => _SellerDashState();
}

class _SellerDashState extends State<SellerDash> {
  @override
  Widget build(BuildContext context) {
    Provider.of<SellerProvider>(context, listen: false).setSeller(
        Provider.of<AccountProvider>(context, listen: false).pharmacyDetails);
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        children: [
          ScreenTitle(
            text1: Provider.of<SellerProvider>(context).title!,
            text2: "",
          ),
          SizedBox(
            height: 15,
          ),
          SalesAndEarningsSummary(),
          SizedBox(height: 15),
          // S_BarChart(),
          SizedBox(height: 15),
          FilteredOrders(
            title: "New Orders",
            filteredOrders: sampleOrders
                .where((element) => element.orderStatus == "need confirmation")
                .toList(),
          ),
          SizedBox(height: 15),
          FilteredOrders(
            title: "Ongoing Orders",
            filteredOrders: sampleOrders
                .where((element) => element.orderStatus == "processing")
                .toList(),
          ),
          SizedBox(height: 15),
          FilteredOrders(
            title: "Completed Orders",
            filteredOrders: sampleOrders
                .where((element) => element.orderStatus == "fulfilled")
                .toList(),
          )
        ],
      ),
    )));
  }
}

class SalesAndEarningsSummary extends StatefulWidget {
  SalesAndEarningsSummary({Key? key}) : super(key: key);

  @override
  _SalesAndEarningsSummaryState createState() =>
      _SalesAndEarningsSummaryState();
}

class _SalesAndEarningsSummaryState extends State<SalesAndEarningsSummary> {
  var analyticSummary;

  @override
  void initState() {
    super.initState();
    String? pharmacy_id =
        Provider.of<SellerProvider>(context, listen: false).id;
    analyticSummary = MysqlService().getPharmacyAnalyticSummary(pharmacy_id!);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: analyticSummary,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }

          if (snapshot.hasData) {
            var data = snapshot.data as Map<String, dynamic>;
            String earnings = data['earnings'];
            String sales = data['sales'];
            return Row(
              children: [
                Expanded(
                    child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: primary_color,
                  ),
                  child: Stack(
                    children: [
                      Text(
                        "Earnings",
                        style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text("${earnings}",
                            style: TextStyle(
                                letterSpacing: 1,
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w900)),
                      ),
                    ],
                  ),
                )),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: accent_color,
                    ),
                    child: Stack(
                      children: [
                        Text(
                          "Sales",
                          style: TextStyle(
                              letterSpacing: 1,
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text("${sales}",
                              style: TextStyle(
                                  letterSpacing: 1,
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900)),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }

          return Center(
              child: Column(
            children: [Text("Loading"), CircularProgressIndicator()],
          ));
        });
  }
}

class FilteredOrders extends StatefulWidget {
  final List<Order> filteredOrders;
  final String title;
  FilteredOrders({required this.filteredOrders, required this.title});

  @override
  _FilteredOrdersState createState() => _FilteredOrdersState();
}

class _FilteredOrdersState extends State<FilteredOrders> {
  @override
  Widget build(BuildContext context) {
    var orders = widget.filteredOrders;
    var title = widget.title;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
              ),
              Spacer(),
              Text(
                "see all",
                style: TextStyle(color: accent_color),
              )
            ],
          ),
          SizedBox(height: 10),
          ListView.builder(
              itemCount: orders.length,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
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
                );
              })
        ],
      ),
    );
  }
}
