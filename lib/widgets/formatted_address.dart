import 'package:flutter/material.dart';

class FormattedAddress extends StatelessWidget {
  final String address;

  FormattedAddress(this.address);

  @override
  Widget build(BuildContext context) {
    return Text(formatAddress(this.address));
  }

  String formatAddress(String test) {
    var indexOfComma = this.address.indexOf(",");
    return this.address.replaceRange(indexOfComma, indexOfComma + 2, "\n");
  }
}
