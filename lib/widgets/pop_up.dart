import 'package:flutter/material.dart';

class PopUp extends StatelessWidget {
  String title;
  String text;
  String answer;
  bool isWarning;
  bool isHighContrast;

  Color titleColor = Colors.green;

  PopUp(this.title, this.text,
      {this.answer = "OK",
      this.isWarning = false,
      this.isHighContrast = false});

  @override
  Widget build(BuildContext context) {
    if (isWarning == true) titleColor = Colors.red;
    if (isHighContrast == true) titleColor = Colors.black;

    Widget okButton = TextButton(
      child: Text(
        this.answer,
        style: TextStyle(color: Colors.blueAccent),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    return AlertDialog(
      title: Text(
        this.title,
        style: TextStyle(color: this.titleColor),
      ),
      content: Text(
        this.text,
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      actions: [
        okButton,
      ],
    );
  }
}
