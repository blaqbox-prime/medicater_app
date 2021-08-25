import 'package:flutter/material.dart';
import 'package:medicater_app/providers/accountProvider.dart';
import 'package:medicater_app/screens/common/login.dart';
import 'package:medicater_app/screens/common/signup2.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    final account = Provider.of<AccountProvider>(context, listen: false);
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 15),
            Center(
              child: Column(
                children: <Widget>[
                  Text(
                    "Sign up",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 24.0,
                      letterSpacing: 5.0,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    height: 1.5,
                    width: 100,
                    color: Theme.of(context).accentColor,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Personal Information",
                    style: TextStyle(
                      color: Colors.blue[300],
                      letterSpacing: 5.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(right: 225),
                  child: Text("First Name"),
                ),
                //SizedBox(height: 3,),
                TextField(
                  onChanged: (value) {
                    account.setFirstName(value);
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "eg.Jane",
                  ),
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                ),
                Container(
                  height: 1.5,
                  width: 300,
                  color: Theme.of(context).accentColor,
                ),

                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(right: 230),
                  child: Text("Last Name"),
                ),
                //SizedBox(height: 3,),
                TextField(
                  onChanged: (value) => account.setLastName(value),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "eg.Doe",
                  ),
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                ),
                Container(
                  height: 1.5,
                  width: 300,
                  color: Theme.of(context).accentColor,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(right: 210),
                  child: Text("SA ID Number"),
                ),
                //SizedBox(height: 3,),
                TextField(
                  onChanged: (value) => account.setIdNo(value),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "5609234563085",
                  ),
                ),
                Container(
                  height: 1.5,
                  width: 300,
                  color: Theme.of(context).accentColor,
                ),
              ]),
            ),
            SizedBox(height: 25),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpB()));
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 15.0),
                height: 50.0,
                width: 300.0,
                color: Colors.blue,
                child: Text("Next",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600)),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              child: Container(
                  child: Text("Already have an account?",
                      style: TextStyle(
                        color: Colors.red,
                      ))),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LogInScreen()));
              },
            ),
            SizedBox(height: 15),
            Container(
                padding: EdgeInsets.only(left: 140),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    ));
  }
}
