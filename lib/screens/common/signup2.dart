import 'package:flutter/material.dart';
import 'package:medicater_app/providers/accountProvider.dart';
import 'package:medicater_app/screens/common/signup3.dart';
import 'package:provider/provider.dart';

class SignUpB extends StatefulWidget {
  @override
  _SignUpBState createState() => _SignUpBState();
}

class _SignUpBState extends State<SignUpB> {
  @override
  Widget build(BuildContext context) {
    var account = Provider.of<AccountProvider>(context);
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
                    "Contact Information",
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
                  padding: EdgeInsets.only(right: 200),
                  child: Text("Mobile Number"),
                ),
                //SizedBox(height: 3,),
                TextField(
                  onChanged: (value) => account.setContactNo(value),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "eg.0728574356",
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
                  padding: EdgeInsets.only(right: 205),
                  child: Text("Email Address"),
                ),
                //SizedBox(height: 3,),
                TextField(
                  onChanged: (value) => account.setEmail(value),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "eg.jane.doe@outlook.com",
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
                  padding: EdgeInsets.only(right: 205),
                  child: Text("Home Address"),
                ),
                //SizedBox(height: 3,),
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "56 Erusmus street...",
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
                    MaterialPageRoute(builder: (context) => RegisterC()));
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
            SizedBox(height: 30),
            Container(
                padding: EdgeInsets.only(left: 140),
                child: Row(
                  children: <Widget>[
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
                  ],
                ))
          ],
        ),
      ),
    ));
  }
}
