import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicater_app/constants.dart';
import 'package:medicater_app/providers/accountProvider.dart';
import 'package:medicater_app/screens/common/login.dart';
import 'package:medicater_app/screens/customer/nav_bar.dart';
import 'package:medicater_app/screens/seller/nav_bar.dart';
import 'package:provider/provider.dart';

class RegisterC extends StatefulWidget {
  RegisterC({Key? key}) : super(key: key);

  @override
  _RegisterCState createState() => _RegisterCState();
}

class _RegisterCState extends State<RegisterC> {
  String passwordMatch = "";
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
                    "Create Password",
                    style: TextStyle(
                      color: Colors.blue[300],
                      letterSpacing: 5.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 120),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(right: 200),
                  child: Text("New Password"),
                ),
                //SizedBox(height: 3,),
                TextField(
                  onChanged: (value) => account.setPassword(value),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "**********",
                  ),
                  obscureText: true,
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
                  child: Text("Confirm Password"),
                ),
                //SizedBox(height: 3,),
                TextField(
                  onChanged: (value) {
                    if (value == account.password) {
                      passwordMatch = "";
                    } else {
                      passwordMatch = "Passwords do not match.";
                    }
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "**********",
                  ),
                  obscureText: true,
                ),
                Text(
                  passwordMatch,
                  style: TextStyle(color: Colors.red, fontSize: 10),
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
                var type = account.usertype;
                //if user type is a customer create a customer account
                if (type == "customer") {
                  account.createCustomer().then((created) => {
                        // print('Customer created: $created'),
                        if (created == false)
                          {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FailedRegister()))
                          }
                        else
                          {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => PageCtrl()))
                          }
                      });
                }
                // if user type is driver create a driver account
                if (type == "driver") {
                  account.createDriver().then((created) => {
                        if (created == false)
                          {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FailedRegister()))
                          }
                        else
                          {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => PageCtrl()))
                          }
                      });
                }
                //if user type is pharmacy create a pharmacy account
                if (type == "pharmacy") {
                  account.createPharmacy().then((created) => {
                        if (created == false)
                          {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FailedRegister()))
                          }
                        else
                          {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => S_Navigator()))
                          }
                      });
                }
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 15.0),
                height: 50.0,
                width: 300.0,
                color: Colors.blue,
                child: Text("Done",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600)),
              ),
            ),
            SizedBox(height: 25),
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
                  ],
                ))
          ],
        ),
      ),
    ));
  }
}

class FailedRegister extends StatelessWidget {
  const FailedRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SvgPicture.asset(
              "assets/images/undraw_access_denied.svg",
              height: 150,
              alignment: Alignment.center,
            ),
            SizedBox(height: 15),
            Text("Registration Failed"),
            SizedBox(
              height: 35,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LogInScreen()));
                },
                style: ButtonStyle(
                  alignment: Alignment.center,
                ),
                child: Text(
                  "Back to Login",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ))
          ],
        ),
      ),
    ));
  }
}
