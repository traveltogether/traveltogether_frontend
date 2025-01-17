import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String text;
  final IconData icon;

  final bool isDefaultValidatorActive;
  final bool isObscure;
  final String Function(String) customValidator;

  TextEditingController _controller;

  TextInput(this.text, this.icon, this._controller,
      {this.isDefaultValidatorActive = true,
      this.customValidator,
      this.isObscure = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscure,
      decoration: InputDecoration(
        prefixIcon: Icon(this.icon),
        hintText: this.text,
        enabledBorder: OutlineInputBorder(borderSide: BorderSide()),
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
