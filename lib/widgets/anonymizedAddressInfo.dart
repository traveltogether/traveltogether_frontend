import 'package:flutter/material.dart';

class AnonymizedAddressInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 4, left: 4),
        child: RichText(
          text: TextSpan(children: [
            TextSpan(text: "mit", style: TextStyle(color: Colors.black)),
            TextSpan(text: ' * ', style: TextStyle(color: Colors.red)),
            TextSpan(
              text: "markierte Addressen wurden anonymisiert",
              style: TextStyle(color: Colors.black),
            )
          ]),
        ));
  }
}
