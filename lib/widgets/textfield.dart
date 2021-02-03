import 'package:flutter/material.dart';

class _Textfield extends StatefulWidget {
  _Textfield({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _TextfieldState createState() => _TextfieldState();
}

class _TextfieldState extends State<_Textfield> {
  String text;
  IconData icon;
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: text,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
            )),
        border: OutlineInputBorder(),
      ),
    );
  }
}