import 'package:flutter/material.dart';

class w_InputField extends StatelessWidget {
  //const w_InputField({Key key}) : super(key: key);
  final String _title;
  final bool _isObscure;
  final String _placeholder;
  final TextEditingController controller;
  w_InputField(
      this._title, this._placeholder, this._isObscure, this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _title,
          ),
          TextField(
            style: TextStyle(fontSize: 16.0),
            decoration: InputDecoration(hintText: _placeholder),
            obscureText: _isObscure,
            controller: controller,
          ),
        ],
      ),
    );
  }
}
