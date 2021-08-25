import 'package:flutter/material.dart';
import 'package:medicater_app/providers/accountProvider.dart';
import 'package:medicater_app/screens/common/signup3.dart';
import 'package:provider/provider.dart';

class VehicleDetailsForm extends StatefulWidget {
  VehicleDetailsForm({Key? key}) : super(key: key);

  @override
  _VehicleDetailsFormState createState() => _VehicleDetailsFormState();
}

class _VehicleDetailsFormState extends State<VehicleDetailsForm> {
  @override
  Widget build(BuildContext context) {
    final account = Provider.of<AccountProvider>(context);
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
                    "Sign Up",
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
                    height: 15.0,
                  ),
                  Text(
                    "What do you drive?",
                    style: TextStyle(
                      color: Colors.blue[300],
                      letterSpacing: 2.0,
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
                  child: Text("Make"),
                ),
                //SizedBox(height: 3,),
                TextField(
                  onChanged: (value) => account.setVehicleMake(value),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "eg.Mazda, Honda, Toyota",
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
                  child: Text("Model"),
                ),
                //SizedBox(height: 3,),
                TextField(
                  onChanged: (value) => account.setVehicleModel(value),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "i10, mx-5, Hilux",
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
                  child: Text("Year"),
                ),
                //SizedBox(height: 3,),
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "2007",
                  ),
                  maxLength: 4,
                ),
                Container(
                  height: 1.5,
                  width: 300,
                  color: Theme.of(context).accentColor,
                ),
              ]),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(right: 205),
              child: Text("Licence Plate"),
            ),
            //SizedBox(height: 3,),
            TextField(
              onChanged: (value) => account.setVehiclePlate(value),
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: "25PL89L",
              ),
              textInputAction: TextInputAction.next,
              maxLength: 7,
              onSubmitted: (_) => FocusScope.of(context).nextFocus(),
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
                alignment: Alignment.center,
                //padding: EdgeInsets.only(left: 140),
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
