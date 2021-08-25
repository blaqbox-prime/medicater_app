import 'package:flutter/material.dart';
import 'package:medicater_app/constants.dart';
import 'package:medicater_app/providers/accountProvider.dart';
import 'package:medicater_app/screens/common/signup3.dart';
import 'package:medicater_app/screens/common/w_Title.dart';
import 'package:provider/provider.dart';

class PharmacySignUpForm extends StatefulWidget {
  PharmacySignUpForm({Key? key}) : super(key: key);

  @override
  _PharmacySignUpFormState createState() => _PharmacySignUpFormState();
}

class _PharmacySignUpFormState extends State<PharmacySignUpForm> {
  @override
  Widget build(BuildContext context) {
    final account = Provider.of<AccountProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              ScreenTitle(
                text1: "Pharmacy",
                text2: "\nDetails",
              ),
              SizedBox(
                height: 15,
              ),
              W_TextField(
                title: "Pharmacy Name",
                hintText: "Pick n Pay Pharmacy Mall of the North",
                onChanged: (value) {
                  account.setBusinessName(value);
                },
              ),
              W_TextField(
                title: "Username",
                hintText: "pnp pharmacy motn",
                onChanged: (value) {
                  account.setBusinessName(value);
                },
              ),
              //-----
              W_TextField(
                title: "Email Address",
                hintText: "motnpharmacy@pnp.co.za",
                onChanged: (value) => {account.setEmail(value)},
              ),
              //-----
              W_TextField(
                title: "Contact",
                hintText: "0158794587",
                onChanged: (value) => account.setContactNo(value),
              ),
              //------
              W_TextField(
                  title: "Street Address",
                  hintText:
                      "Shop 27 Mall of The North Cnr Munnik and Phaladi Street",
                  onChanged: (value) => account.setStreetAddr(value)),
              //----
              W_TextField(
                title: "Suburb",
                hintText: "Bendor Ext 87",
                onChanged: (value) => account.setSuburb(value),
              ),
              //----
              W_TextField(
                title: "City",
                hintText: "Polokwane",
                onChanged: (value) => account.setCity(value),
              ),
              //----
              W_TextField(
                title: "Province",
                hintText: "Limpopo",
                onChanged: (value) => account.setProvince(value),
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
            ],
          ),
        ),
      ),
    );
  }
}

// ======================== Text Field
class W_TextField extends StatelessWidget {
  final String title;
  final String hintText;
  final void Function(String) onChanged;

  W_TextField({
    Key? key,
    required this.title,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
          //SizedBox(height: 3,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: accent_color,
                        width: 1,
                        style: BorderStyle.solid))),
            child: TextField(
              onChanged: (value) => onChanged,
              decoration: InputDecoration.collapsed(
                hintText: hintText,
              ),
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => FocusScope.of(context).nextFocus(),
            ),
          ),
        ],
      ),
    );
  }
}
