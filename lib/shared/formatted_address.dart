import 'package:flutter/material.dart';

class FormattedAddress extends StatelessWidget {
  String address;
  
  FormattedAddress(this.address);

  @override
  Widget build(BuildContext context) {
    return Text(this.address);
  }
}