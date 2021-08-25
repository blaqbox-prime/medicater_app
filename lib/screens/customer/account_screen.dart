import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicater_app/models/customer.dart';
import 'package:medicater_app/providers/accountProvider.dart';
import 'package:medicater_app/screens/common/start_screen.dart';
import 'package:medicater_app/screens/customer/nav_bar.dart';
import 'package:medicater_app/screens/customer/profile.dart';
import 'package:medicater_app/screens/customer/upload_file_screen.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    Customer customer = Provider.of<AccountProvider>(context).customerDetails;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(shrinkWrap: true, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                SvgPicture.asset(
                  int.parse(customer.custId![6]) > 4
                      ? "assets/images/undraw_male_avatar.svg"
                      : "assets/images/undraw_female_avatar.svg",
                  height: 120,
                  alignment: Alignment.center,
                  clipBehavior: Clip.antiAlias,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "${customer.firstName} ${customer.lastName}",
                  style: TextStyle(fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.userCircle),
              title: Text("Edit profile"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PageCtrl(
                          screen: CustomerProfile(),
                        )));
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.bookmark),
              title: Text("Shortlist"),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.prescription),
              title: Text("Upload prescription"),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => UploadFile(fileTitle: "prescription"))),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.passport),
              title: Text("Upload ID document"),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => UploadFile(fileTitle: "Id"))),
            ),
            GestureDetector(
              onTap: () => {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => StartScreen()))
              },
              child: ListTile(
                leading: Icon(FontAwesomeIcons.doorOpen),
                title: Text("Log Out"),
              ),
            )
          ]),
        ),
      ),
    ));
  }
}
