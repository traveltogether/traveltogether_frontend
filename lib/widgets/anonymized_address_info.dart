import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/theme_service.dart';

class AnonymizedAddressInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 4, left: 4),
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: "mit",
                style: TextStyle(
                    color: ThemeService.data.textTheme.bodyText1.color)),
            TextSpan(text: ' * ', style: TextStyle(color: Colors.red)),
            TextSpan(
                text: "markierte Addressen wurden anonymisiert",
                style: TextStyle(
                    color: ThemeService.data.textTheme.bodyText1.color))
          ]),
        ));
  }
}
