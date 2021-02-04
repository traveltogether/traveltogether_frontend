import 'package:flutter/material.dart';


class TextInput extends StatelessWidget{
  final String text;
  final IconData icon;


  TextEditingController _controller;

  TextInput(this.text, this.icon, this._controller);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(this.icon),
        hintText: this.text,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
            )),
        border: OutlineInputBorder(),
      ),
      controller: this._controller,
      validator: (value) {
        if(value.isEmpty) return "Bitte Eingabefeld ausfüllen";
        return null;
      }
    );
  }
}