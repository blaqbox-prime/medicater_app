import 'package:flutter/material.dart';
import 'package:medicater_app/screens/common/w_Title.dart';

import 'components/s_ProductForm.dart';

class CreateProduct extends StatelessWidget {
  const CreateProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: [
            ScreenTitle(
              text1: "Create",
              text2: "\nNew Product",
            ),
            SizedBox(height: 20),
            ProductForm(),
          ],
        ),
      )),
    );
  }
}
