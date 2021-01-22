import 'package:flutter/material.dart';

class FormattedDateTime extends StatelessWidget {
  String dateTime;

  FormattedDateTime(this.dateTime);

  @override
  Widget build(BuildContext context) {
    return Text(this.dateTime);
  }
}
