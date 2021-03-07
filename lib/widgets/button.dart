import 'package:flutter/material.dart';

class Button extends StatelessWidget {

  String text;
  Color customTextColor;
  Button(this.text, {this.customTextColor = Colors.black87});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: null,
        child: Text(this.text, style: TextStyle(color: this.customTextColor)),
    );
  }
}