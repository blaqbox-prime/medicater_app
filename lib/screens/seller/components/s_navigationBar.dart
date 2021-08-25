import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicater_app/constants.dart';
import 'package:medicater_app/models/pharmacy.dart';
import 'package:medicater_app/screens/seller/s_account.dart';
import 'package:medicater_app/screens/seller/s_dashboard.dart';
import 'package:medicater_app/screens/seller/s_orders.dart';
import 'package:medicater_app/screens/seller/s_productListings.dart';

class SellerNavigator extends StatefulWidget {
  Pharmacy pharmacy;
  SellerNavigator(this.pharmacy);
  @override
  _SellerNavigatorState createState() => _SellerNavigatorState();
}

class _SellerNavigatorState extends State<SellerNavigator> {
  List pages = [
    SellerDash(),
    S_OrdersScreen(),
    ProductListingScreen(
      pharmacy: Pharmacy(),
    ),
    S_AccountScreen()
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          backgroundColor: bg_color,
          elevation: 0.0,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.home), title: Text('Dashboard')),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.inbox), title: Text('Orders')),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.productHunt),
                title: Text('Products')),
          ]),
    );
  }
}
