import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicater_app/constants.dart';
import 'package:medicater_app/models/cart.dart';
import 'package:medicater_app/models/product.dart';
import 'package:medicater_app/screens/customer/nav_bar.dart';
import 'package:medicater_app/size_config.dart';
import 'package:provider/provider.dart';

import 'checkout_screen.dart';

class ProductDetail extends StatefulWidget {
  final Product? product;
  ProductDetail({this.product});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var product = widget.product;
    var size = MediaQuery.of(context).size;
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: text_color,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        actions: [
          IconButton(
              icon: FaIcon(
                FontAwesomeIcons.shoppingBag,
                color: text_color,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PageCtrl(
                          screenIndex: 1,
                        )));
              })
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: size.width,
                height: size.height * 0.35,
                color: bg_color,
                child: product!.img != null
                    ? Image.network(product.img!,
                        alignment: Alignment.center, fit: BoxFit.cover)
                    : Image.asset("assets/images/logo.png",
                        alignment: Alignment.center, fit: BoxFit.cover)),
            SizedBox(height: 10),
            Text(
              product.name!,
              style: TextStyle(
                  color: text_color, fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              product.description!,
              style: TextStyle(letterSpacing: 0.5),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                height: 2,
                width: getProportionateScreenWidth(200),
                color: accent_color,
              ),
            ),
            Text(
              'Recommendations',
              style: TextStyle(
                  color: text_color,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5),
            ),
            SizedBox(
              height: 10,
            ),
            Text(product.recommendation!),
            Container(
              height: 90,
              width: size.width,
              child: Row(
                children: [
                  Text(
                    "Qty: $quantity",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: 30,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              quantity++;
                            });
                          },
                          child: Icon(
                            Icons.keyboard_arrow_up,
                            size: 24,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (quantity > 1) quantity--;
                            });
                          },
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            //Total
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: TextStyle(
                      fontSize: 22,
                      color: text_color,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  "R${(quantity * product.price!).toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 22,
                      color: primary_color,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
            //Add to cart
            ElevatedButton(
                onPressed: () {
                  cart.addProduct(product, quantity: quantity);
                  Scaffold.of(context).showSnackBar(new SnackBar(
                    content: Text("$quantity x ${product.name} added to cart"),
                    action: SnackBarAction(
                        label: "dismiss",
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ));
                },
                child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Add to Cart",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ))),
          ],
        ),
      )),
    );
  }
}
