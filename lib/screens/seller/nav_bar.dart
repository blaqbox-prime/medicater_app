import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicater_app/constants.dart';
import 'package:medicater_app/models/pharmacy.dart';
import 'package:medicater_app/screens/seller/s_dashboard.dart';
import 'package:medicater_app/screens/seller/s_orders.dart';
import 'package:medicater_app/screens/seller/s_productListings.dart';

import 's_account.dart';

class S_Navigator extends StatefulWidget {
  S_Navigator({Key? key}) : super(key: key);

  @override
  _S_NavigatorState createState() => _S_NavigatorState();
}

class _S_NavigatorState extends State<S_Navigator> {
  List<Widget> sellerMainPages = [
    SellerDash(),
    ProductListingScreen(
      pharmacy: Pharmacy(),
    ),
    S_OrdersScreen(),
    S_AccountScreen()
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: sellerMainPages[_index],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              //Home Button
              icon: FaIcon(
                FontAwesomeIcons.home,
                size: 20,
              ),
              label: ("Home")),
          BottomNavigationBarItem(
            //Product Listings
            icon: FaIcon(
              FontAwesomeIcons.list,
              size: 20,
            ),
            label: ("Listings"),
          ),
          BottomNavigationBarItem(
            //Orders
            icon: FaIcon(
              FontAwesomeIcons.shoppingBag,
              size: 20,
            ),
            label: ("orders"),
          ),
          BottomNavigationBarItem(
            //Account
            icon: FaIcon(
              FontAwesomeIcons.user,
              size: 20,
            ),
            label: ("Account"),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
        currentIndex: _index,
        selectedItemColor: primary_color,
        unselectedItemColor: text_color,
        showUnselectedLabels: true,
        unselectedLabelStyle: TextStyle(color: text_color),
      ),
    );
  }
}
