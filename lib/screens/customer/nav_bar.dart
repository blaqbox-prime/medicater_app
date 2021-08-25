import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicater_app/models/cart.dart';
import 'package:medicater_app/screens/customer/account_screen.dart';
import 'package:medicater_app/screens/customer/explore_screen.dart';
import 'package:medicater_app/screens/customer/medical_newsfeed.dart';
import 'package:medicater_app/screens/customer/my_orders.dart';
import 'package:provider/provider.dart';

import 'checkout_screen.dart';

class PageCtrl extends StatefulWidget {
  final Widget? screen;
  final int? screenIndex;
  PageCtrl({Key? key, this.screen, this.screenIndex});

  @override
  _PageCtrlState createState() => _PageCtrlState();
}

class _PageCtrlState extends State<PageCtrl> {
  int screenIndex = 0;
  late Widget? screen;

  final List<Widget> _children = [
    ExploreScreen(),
    CheckoutScreen(),
    MyOrders(),
    AccountScreen(),
    NewsFeedScreen()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    screen = widget.screen;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.screenIndex != null) {
      screenIndex = widget.screenIndex!;
    }

    return Scaffold(
        body: screen == null ? _children[screenIndex] : screen,
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0.0,
          iconSize: 22.0,
          unselectedIconTheme: IconThemeData(color: Colors.black87),
          selectedIconTheme: IconThemeData(color: Colors.blue),
          items: [
            BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.compass,
                ),
                label: ('Explore')),
            BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.shoppingBasket,
                ),
                label: ('Cart')),
            BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.receipt,
                ),
                label: ('My Orders')),
            BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.user,
                ),
                label: ('Account')),
            BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.book,
                ),
                label: ('bookmarks'))
          ],
          onTap: (value) {
            setState(() {
              screen = null;
              screenIndex = value;
            });
          },
          currentIndex: screenIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
        ));
  }
}
