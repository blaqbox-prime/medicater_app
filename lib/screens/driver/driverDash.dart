import 'package:flutter/material.dart';
import 'package:medicater_app/models/order.dart';
import 'package:medicater_app/providers/accountProvider.dart';
import 'package:medicater_app/screens/common/w_Title.dart';
import 'package:medicater_app/screens/seller/s_dashboard.dart';
import 'package:provider/provider.dart';

class DriverDashboard extends StatefulWidget {
  DriverDashboard({Key? key}) : super(key: key);

  @override
  _DriverDashboardState createState() => _DriverDashboardState();
}

class _DriverDashboardState extends State<DriverDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        children: [
          ScreenTitle(
            text1: Provider.of<AccountProvider>(context)
                .deliveryManDetails
                .firstName!,
            text2: Provider.of<AccountProvider>(context)
                .deliveryManDetails
                .lastName!,
          ),
          SizedBox(
            height: 15,
          ),
          _deliveriesAndEarningsSummary(),
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

  _deliveriesAndEarningsSummary() {}
}
