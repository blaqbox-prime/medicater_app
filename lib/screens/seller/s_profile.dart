import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicater_app/providers/accountProvider.dart';
import 'package:medicater_app/providers/sellerProvider.dart';
import 'package:medicater_app/screens/common/pharmacySignUp.dart';
import 'package:medicater_app/screens/common/w_Title.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class S_Profile extends StatefulWidget {
  S_Profile({Key? key}) : super(key: key);

  @override
  _S_ProfileState createState() => _S_ProfileState();
}

class _S_ProfileState extends State<S_Profile> {
  @override
  Widget build(BuildContext context) {
    final pharm = Provider.of<SellerProvider>(context).pharmacy;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: ListView(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          children: [
            ScreenTitle(text1: "Pharmacy", text2: 'Profile'),
            SizedBox(
              height: 15,
            ),
            W_TextField(
              title: "Email",
              hintText: pharm.email!,
              onChanged: (value) => AccountProvider().setEmail(value),
            ),
            W_TextField(
              title: "Contact",
              hintText: pharm.contact!,
              onChanged: (value) {
                AccountProvider().setContactNo(value);
              },
            ),
            W_TextField(
              title: "name",
              hintText: pharm.name!,
              onChanged: (value) => AccountProvider().setBusinessName(value),
            ),
            ExpansionTile(
              title: Text("Business Address"),
              trailing: Icon(
                FontAwesomeIcons.angleDown,
                size: 25,
                color: accent_color,
              ),
              children: [
                W_TextField(
                  title: "Street Address",
                  hintText: pharm.street!,
                  onChanged: (value) => AccountProvider().setStreetAddr(value),
                ),
                W_TextField(
                  title: "Suburb",
                  hintText: pharm.suburb!,
                  onChanged: (value) => AccountProvider().setSuburb(value),
                ),
                W_TextField(
                  title: "City",
                  hintText: pharm.city!,
                  onChanged: (value) => AccountProvider().setCity(value),
                ),
                W_TextField(
                  title: "Province",
                  hintText: pharm.province!,
                  onChanged: (value) => AccountProvider().setProvince(value),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: ElevatedButton(
                          onPressed: () => {}, child: Text("update")),
                    ),
                  ],
                )
              ],
            ),
            Container(
              child: ElevatedButton(
                  onPressed: () => {}, child: Text("Update profile")),
            )
          ],
        ),
      )),
    );
  }
}
