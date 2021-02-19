import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String text;
  final IconData icon;

  final bool isDefaultValidatorActive;
  final String Function(String) customValidator;

  TextEditingController _controller;

  TextInput(this.text, this.icon, this._controller,
      {this.isDefaultValidatorActive = true, this.customValidator});

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
        if (value.isEmpty && isDefaultValidatorActive) {
          return "Bitte Eingebefeld ausfüllen";
        } else if (this.customValidator != null) {
          return this.customValidator(value);
        }
        return null;
      },
    );
  }
}