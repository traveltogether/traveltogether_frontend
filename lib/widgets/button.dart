import 'package:flutter/material.dart';

class Button extends StatelessWidget {

  String text;
  Color customTextColor;
  Button(this.text, {this.customTextColor = Colors.green});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        textColor: this.customTextColor,
        onPressed: null,
        child: Text(this.text),
    );
  }
}