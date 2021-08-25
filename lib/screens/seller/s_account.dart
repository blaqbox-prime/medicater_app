import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicater_app/providers/sellerProvider.dart';
import 'package:medicater_app/screens/common/start_screen.dart';
import 'package:medicater_app/screens/customer/upload_file_screen.dart';
import 'package:medicater_app/screens/seller/s_profile.dart';
import 'package:provider/provider.dart';

class S_AccountScreen extends StatefulWidget {
  S_AccountScreen({Key? key}) : super(key: key);

  @override
  _S_AccountScreenState createState() => _S_AccountScreenState();
}

class _S_AccountScreenState extends State<S_AccountScreen> {
  @override
  Widget build(BuildContext context) {
    final pharm = Provider.of<SellerProvider>(context).pharmacy;
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
                pharm.logo != null
                    ? Image.network(
                        pharm.logo!,
                        height: 120,
                        alignment: Alignment.center,
                      )
                    : SvgPicture.asset(
                        "assets/images/undraw_male_avatar.svg",
                        height: 120,
                        alignment: Alignment.center,
                        clipBehavior: Clip.antiAlias,
                      ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "${pharm.name}",
                  style: TextStyle(fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.building),
              title: Text("Edit profile"),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => S_Profile())),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.image),
              title: Text("Upload new logo"),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => UploadFile(fileTitle: "logo"))),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.dollarSign),
              title: Text("Revenues"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.doorOpen),
              title: Text("Log Out"),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => StartScreen())),
            )
          ]),
        ),
      ),
    ));
  }
}
