import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicater_app/constants.dart';
import 'package:medicater_app/models/address.dart';
import 'package:medicater_app/providers/accountProvider.dart';
import 'package:medicater_app/screens/common/pharmacySignUp.dart';
import 'package:medicater_app/screens/common/w_Title.dart';
import 'package:provider/provider.dart';

class CustomerProfile extends StatefulWidget {
  CustomerProfile({Key? key}) : super(key: key);

  @override
  _CustomerProfileState createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  @override
  Widget build(BuildContext context) {
    final authUser = Provider.of<AccountProvider>(context).customerDetails;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: ListView(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          children: [
            ScreenTitle(
                text1: authUser.firstName!, text2: '\n${authUser.lastName!}'),
            SizedBox(
              height: 15,
            ),
            W_TextField(
              title: "First Name",
              hintText: authUser.firstName!,
              onChanged: (value) => authUser.setFirstName(value),
            ),
            W_TextField(
              title: "Last Name",
              hintText: authUser.lastName!,
              onChanged: (value) {
                authUser.setLastName(value);
                print(authUser.lastName);
              },
            ),
            W_TextField(
              title: "Email",
              hintText: authUser.email!,
              onChanged: (value) => AccountProvider().setEmail(value),
            ),
            W_TextField(
              title: "Contact",
              hintText: authUser.contact!,
              onChanged: (value) => AccountProvider().setFirstName(value),
            ),
            ExpansionTile(
              title: Text("Home Address"),
              trailing: Icon(
                FontAwesomeIcons.angleDown,
                size: 25,
                color: accent_color,
              ),
              children: [
                W_TextField(
                  title: "Street Address",
                  hintText: authUser.homeAddress!.street!,
                  onChanged: (value) => AccountProvider().setStreetAddr(value),
                ),
                W_TextField(
                  title: "Suburb",
                  hintText: authUser.homeAddress!.suburb!,
                  onChanged: (value) => AccountProvider().setSuburb(value),
                ),
                W_TextField(
                  title: "City",
                  hintText: authUser.homeAddress!.city!,
                  onChanged: (value) => AccountProvider().setCity(value),
                ),
                W_TextField(
                  title: "Province",
                  hintText: authUser.homeAddress!.province!,
                  onChanged: (value) => AccountProvider().setFirstName(value),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: ElevatedButton(
                          onPressed: () => {}, child: Text("update")),
                    ),
                    Container(
                      child: ElevatedButton(
                          onPressed: () => {
                                setState(() => {
                                      authUser.homeAddress = Address.fromMap(
                                          authUser.deliveryAddress!.toMap())
                                    })
                              },
                          child: Text("Same as Delivery"),
                          style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              side: MaterialStateProperty.all(BorderSide(
                                  color: accent_color,
                                  style: BorderStyle.solid,
                                  width: 1)))),
                    )
                  ],
                )
              ],
            ),
            ExpansionTile(
              title: Text("Delivery Address"),
              trailing: Icon(
                FontAwesomeIcons.angleDown,
                size: 25,
                color: accent_color,
              ),
              children: [
                W_TextField(
                  title: "Street Address",
                  hintText: authUser.homeAddress!.street!,
                  onChanged: (value) => AccountProvider().setStreetAddr(value),
                ),
                W_TextField(
                  title: "Suburb",
                  hintText: authUser.homeAddress!.suburb!,
                  onChanged: (value) => AccountProvider().setSuburb(value),
                ),
                W_TextField(
                  title: "City",
                  hintText: authUser.homeAddress!.city!,
                  onChanged: (value) => AccountProvider().setCity(value),
                ),
                W_TextField(
                  title: "Province",
                  hintText: authUser.homeAddress!.province!,
                  onChanged: (value) => AccountProvider().setFirstName(value),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: ElevatedButton(
                          onPressed: () => {}, child: Text("update")),
                    ),
                    Container(
                      child: ElevatedButton(
                          onPressed: () => {
                                setState(() => {
                                      authUser.deliveryAddress =
                                          Address.fromMap(
                                              authUser.homeAddress!.toMap())
                                    })
                              },
                          child: Text("Same as Home"),
                          style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              side: MaterialStateProperty.all(BorderSide(
                                  color: accent_color,
                                  style: BorderStyle.solid,
                                  width: 1)))),
                    )
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
