import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Button extends StatelessWidget {
  String text;
  Color customTextColor;
  double customTextScale;

  Button(this.text,
      {this.customTextColor = Colors.black87, this.customTextScale = 1.0});

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: null,
      child: Text(
        this.text,
        style: TextStyle(color: this.customTextColor),
        textScaleFactor: this.customTextScale,
        textAlign: TextAlign.right,
      ),
    );
  }
}
