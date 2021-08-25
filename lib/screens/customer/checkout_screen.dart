import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicater_app/constants.dart';
import 'package:medicater_app/models/cart.dart';
import 'package:medicater_app/models/driver.dart';
import 'package:medicater_app/models/order.dart';
import 'package:medicater_app/models/product.dart';
import 'package:medicater_app/models/user.dart';
import 'package:medicater_app/models/vehicle.dart';
import 'package:medicater_app/providers/accountProvider.dart';
import 'package:medicater_app/providers/orderProvider.dart';
import 'package:medicater_app/providers/sellerProvider.dart';
import 'package:medicater_app/screens/customer/explore_screen.dart';
import 'package:medicater_app/screens/customer/nav_bar.dart';
import 'package:medicater_app/screens/customer/payment_screen.dart';
import 'package:medicater_app/screens/customer/successful_order.dart';
import 'package:medicater_app/services/mysql_service.dart';
import 'package:provider/provider.dart';

import '../../size_config.dart';
import 'components/cartItemCard.dart';

class CheckoutScreen extends StatefulWidget {
  CheckoutScreen();

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isCashPayment = true;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    //Cart provider holds cart items throughout the app
    final cart = Provider.of<Cart>(context);
    var order = Provider.of<OrderProvider>(context, listen: false);
    var account = Provider.of<AccountProvider>(context, listen: false);
    var seller = Provider.of<SellerProvider>(context, listen: false);

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(shrinkWrap: true, children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: 'Checkout',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.black87,
                        fontSize: 38)),
                TextSpan(
                    text: '\nShopping Cart.',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.blueGrey,
                        fontSize: 34)),
              ]),
              softWrap: true,
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 30,
            ),

            /// Cart Total
            Center(
              child: Text(
                'R${cart.cartTotal.toStringAsFixed(2)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                    color: primary_color,
                    letterSpacing: 2.5),
              ),
            ),
            Center(
              child: Container(
                height: 2.0,
                alignment: Alignment.center,
                width: 100,
                color: accent_color,
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(10)),
                child: cart.cartItems.length > 0
                    ? ListView.builder(
                        itemCount: cart.cartItems.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Dismissible(
                                key: Key(cart.cartItems[0].product!.productId
                                    as String),
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                      color: Colors.red[100],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      FaIcon(
                                        FontAwesomeIcons.trashAlt,
                                        color: Colors.red[600],
                                      )
                                    ],
                                  ),
                                ),
                                onDismissed: (direction) {
                                  setState(() {
                                    cart.cartTotal -=
                                        (cart.cartItems[index].total);
                                    cart.cartItems.removeAt(index);
                                  });
                                },
                                child: CartItemCard(
                                    cartItem: cart.cartItems[index])),
                          );
                        })
                    : Center(
                        ///If the cart is empty show message and continue Shopping button
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Text(
                              "Cart is empty.",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 20),
                            ContinueShopping_btn()
                          ],
                        ),
                      ),
              ),
            ),
          ]),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => cart.items != 0
            ? showModalBottomSheet(
                context: context,
                builder: (context) => _buildBottomSheet(context))
            : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Cart is empty. Add products and try again"),
              )),
        isExtended: true,
        child: Text("Pay"),
      ),
    );
  }

  Container _buildBottomSheet(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    var order = Provider.of<OrderProvider>(context, listen: false);
    var account = Provider.of<AccountProvider>(context, listen: false);
    var seller = Provider.of<SellerProvider>(context, listen: false);

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text("Select payment method"),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                children: [
                  ListTile(
                    onTap: () => {
                      setState(() => {
                            if (!isCashPayment) {isCashPayment = !isCashPayment}
                          })
                    },
                    leading: Icon(
                      FontAwesomeIcons.moneyBill,
                      color: Colors.green,
                    ),
                    title: Text("Cash"),
                    subtitle: Text(
                      "Pay cash on delivery",
                      style: TextStyle(fontSize: 12),
                    ),
                    trailing: isCashPayment
                        ? Icon(
                            Icons.radio_button_checked,
                            color: accent_color,
                          )
                        : Icon(Icons.radio_button_unchecked,
                            color: Colors.grey),
                  ),
                  //card Payment tile
                  ListTile(
                    onTap: () => {
                      setState(() => {
                            if (isCashPayment) {isCashPayment = !isCashPayment}
                          })
                    },
                    leading: Icon(
                      FontAwesomeIcons.moneyCheckAlt,
                      color: Colors.black87,
                    ),
                    title: Text("Debit/Credit card"),
                    subtitle: Text(
                      "Charge your bank account",
                      style: TextStyle(fontSize: 12),
                    ),
                    trailing: !isCashPayment
                        ? Icon(
                            Icons.radio_button_checked,
                            color: accent_color,
                          )
                        : Icon(Icons.radio_button_unchecked,
                            color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Card Number",
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Security Code",
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          keyboardType: TextInputType.text,
                          maxLength: 5,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Expire Date",
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: ElevatedButton(
                        onPressed: () {
                          order.order = new Order(
                              billAmnt: cart.cartTotal + cart.cartTotal * 0.15,
                              customer: account.customerDetails,
                              delivAddress: account.customerDetails.homeAddress,
                              orderDate: DateTime.now(),
                              orderItems: cart.cartItems,
                              pharmacy: seller.pharmacy,
                              deliveryMan: new DeliveryMan(
                                  userId:
                                      "1a539b2a-9374-435b-8f10-ecf7b3d4231a",
                                  driverId: "9511205652081",
                                  contact: "0744878745",
                                  vehicle: new Vehicle.fromString(
                                      "Renault Clio 2020 25AB89L")));
                          order.saveOrder();
                          order.send();

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => OrderSuccessful()));
                        },
                        child: Text("Pay")),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ContinueShopping_btn extends StatelessWidget {
  const ContinueShopping_btn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PageCtrl(
                  screenIndex: 0,
                )));
      },
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 2, style: BorderStyle.solid)),
        child: Text(
          "Continue Shopping",
          style: TextStyle(
              fontWeight: FontWeight.w800, fontSize: 16, color: Colors.black),
        ),
      ),
    );
  }
}

class ContinueToPayment_btn extends StatelessWidget {
  const ContinueToPayment_btn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var order = Provider.of<OrderProvider>(context, listen: false);
    var cart = Provider.of<Cart>(context, listen: false);
    var account = Provider.of<AccountProvider>(context, listen: false);
    var seller = Provider.of<SellerProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        order.order = new Order(
            billAmnt: cart.cartTotal + cart.cartTotal * 0.15,
            customer: account.customerDetails,
            delivAddress: account.customerDetails.homeAddress,
            orderDate: DateTime.now(),
            orderItems: cart.cartItems,
            pharmacy: seller.pharmacy,
            deliveryMan: new DeliveryMan(
                userId: "1a539b2a-9374-435b-8f10-ecf7b3d4231a",
                driverId: "9511205652081",
                contact: "0744878745",
                vehicle: new Vehicle.fromString("Renault Clio 2020 25AB89L")));
        order.saveOrder();
        order.send();
      },
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(color: primary_color),
        child: Text(
          "Continue to payment",
          style: TextStyle(
              fontWeight: FontWeight.w800, fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
