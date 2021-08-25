import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medicater_app/providers/accountProvider.dart';
import 'package:medicater_app/screens/common/w_inputField.dart';
import 'package:medicater_app/services/mysql_service.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatefulWidget {
  LogInScreen({Key? key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController username_edt = new TextEditingController();
  final TextEditingController password_edt = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final accountHandler = Provider.of<AccountProvider>(context);
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: Center(
            child: SvgPicture.asset(
              "assets/images/undraw_healthy_options.svg",
              height: 150.0,
              //width: 210.0,
            ),
          ),
        ),
        w_InputField('Username', 'eg. janedoe@gmail.com', false, username_edt),
        SizedBox(height: 30.0),
        w_InputField('Password', 'Enter Password', true, password_edt),
        SizedBox(height: 30.0),
        GestureDetector(
          onTap: () {
            accountHandler.login(username_edt.text, password_edt.text,
                context: context);
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30.0),
            width: MediaQuery.of(context).size.width,
            height: 50.0,
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Center(
                child: Text(
              'Log In',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            )),
          ),
        ),
        SizedBox(height: 30.0),
        Text('Forgot Password?', style: TextStyle(color: Colors.red)),
        Container(
          margin: EdgeInsets.only(top: 5),
          height: 1.0,
          color: Theme.of(context).accentColor,
          width: 80.0,
        ),
        SizedBox(height: 30.0),
      ],
    ));
  }
}
