import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget {
  final String text1;
  final String text2;
  const ScreenTitle({required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
            text: text1,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.black87,
              fontSize: 38,
            )),
        TextSpan(
            text: text2,
            style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.blueGrey,
                fontSize: 34)),
      ]),
      softWrap: true,
      textAlign: TextAlign.start,
    );
  }
}
