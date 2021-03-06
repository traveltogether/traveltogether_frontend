import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/pages/main.dart';

class PopUp extends StatelessWidget {
  String title;
  String text;
  String answer;
  bool isWarning;

  Color backgroundColor = Colors.white;
  Color textColor = Colors.black;
  Color titleColor = Colors.green;

  PopUp(this.title, this.text, {this.answer = "OK", this.isWarning = false});

  @override
  Widget build(BuildContext context) {
    if(isWarning==true) titleColor = Colors.red;

    Widget okButton = FlatButton(
      child: Text(this.answer, style: TextStyle(color: Colors.blueAccent),),
      //color: Colors.black,
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    return AlertDialog(
      title: Text(this.title, style: TextStyle(color: this.titleColor),),
      content: Text(this.text, style: TextStyle(color: textColor),),
      backgroundColor: this.backgroundColor,
      actions: [
        okButton,
      ],
    );
  }
}
