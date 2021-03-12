import 'package:flutter/material.dart';

class FormattedAddress extends StatelessWidget {
  final String address;
  final bool isAnonymized;

  FormattedAddress(this.address, this.isAnonymized);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: formatAddress(this.address),
          style: TextStyle(color: Colors.black),
          children: [
            if (isAnonymized)
              TextSpan(text: ' *', style: TextStyle(color: Colors.red))
          ]),
    );
  }

  String formatAddress(String test) {
    var indexOfComma = this.address.indexOf(",");
    return this.address.replaceRange(indexOfComma, indexOfComma + 2, "\n");
  }
}
