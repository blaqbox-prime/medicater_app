import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicater_app/screens/common/login.dart';
import 'package:medicater_app/screens/common/signup.dart';
import 'package:uuid/uuid.dart';
import 'chooseUserType.dart';

class StartScreen extends StatefulWidget {
  StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  Uuid uid = Uuid();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: ,
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.center,
              //color: Colors.lightBlue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/logo.png",
                    height: 100.0,
                    //width: 210.0,
                  ),
                  Text(
                    "MediCater",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24.0,
                      letterSpacing: 7.0,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    height: 1.5,
                    width: 125,
                    color: Theme.of(context).accentColor,
                  )
                ],
              ),
            ),
          ),
          // Login Button Container
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => LogInScreen()));
            },
            child: Container(
              // Sign In Button -------------------------------------------------
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 15.0),
              height: 50.0,
              width: 300.0,
              color: Theme.of(context).primaryColor,
              child: Text("Sign In",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600)),
            ),
          ),
          SizedBox(height: 10.0),
          // Sign Up Button --------------------------------------------
          Container(
            // Sign Up Text Section
            margin: EdgeInsets.only(
              bottom: 15.0,
            ),
            height: 30.0,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don't have an account?",
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    SizedBox(width: 5.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChooseUserType()));
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.0),
                Container(
                  // Blue UnderLine
                  height: 1.0,
                  width: 126.0,
                  color: Theme.of(context).accentColor,
                ),
              ],
            ),
          ),
          SizedBox(height: 40.0),
          //FlatButton(onPressed: ()=>{}, child: null)
        ],
      ),
    ));
  }
}
