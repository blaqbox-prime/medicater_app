import 'dart:io';

import 'package:flutter/material.dart';
import 'package:medicater_app/constants.dart';
import 'package:medicater_app/models/product.dart';
import 'package:medicater_app/screens/common/w_Title.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicater_app/screens/seller/components/s_ProductForm.dart';

class S_EditProduct extends StatefulWidget {
  Product product;
  S_EditProduct({required this.product});

  @override
  _S_EditProductState createState() => _S_EditProductState();
}

class _S_EditProductState extends State<S_EditProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            ScreenTitle(
              text1: "Edit",
              text2: "\nProduct Listing",
            ),
            SizedBox(
              height: 15,
            ),
            ProductForm(
              product: widget.product,
            ),
          ],
        ),
      )),
    );
  }
}
