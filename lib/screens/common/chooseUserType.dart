import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medicater_app/providers/accountProvider.dart';
import 'package:medicater_app/screens/common/pharmacySignUp.dart';
import 'package:medicater_app/screens/common/signup.dart';
import 'package:medicater_app/screens/common/signup2.dart';
import 'package:medicater_app/screens/common/w_Title.dart';
import 'package:provider/provider.dart';

class ChooseUserType extends StatelessWidget {
  const ChooseUserType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final account = Provider.of<AccountProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              ScreenTitle(
                text1: "Who",
                text2: "\nAre You?",
              ),
              //---
              SizedBox(height: 15),
              //--
              GestureDetector(
                child: UserTypeCard(
                  image: "assets/images/undraw_empty_cart.svg",
                  title: "I'm a customer",
                  subtitle: "The pharmacy at your fingertips",
                ),
                onTap: () {
                  account.setUserType("customer");
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => SignUp()));
                },
              ),

              GestureDetector(
                child: UserTypeCard(
                  image: "assets/images/undraw_On_the_way.svg",
                  title: "I want to deliver",
                  subtitle: "Join our team of dependable deliverymen and women",
                ),
                onTap: () {
                  account.setUserType("driver");
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => SignUp()));
                },
              ),

              GestureDetector(
                child: UserTypeCard(
                  image: "assets/images/undraw_medical_care.svg",
                  title: "Accredited Pharmacy",
                  subtitle: "List your products and grow your customers",
                ),
                onTap: () {
                  account.setUserType("pharmacy");
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PharmacySignUpForm()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UserTypeCard extends StatelessWidget {
  final String? image;
  final String? title;
  final String? subtitle;

  const UserTypeCard({Key? key, this.image, this.title, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 15),
          child: Center(
            child: Column(
              children: [
                SvgPicture.asset(
                  image!,
                  height: 120,
                  fit: BoxFit.scaleDown,
                ),
                SizedBox(height: 30),
                Text(
                  title!,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 2),
                Text(subtitle!, textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
