import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormattedDateTime extends StatelessWidget {
  final int dateTime;

  FormattedDateTime(this.dateTime);

  @override
  Widget build(BuildContext context) {
    return Text(getDateTime());
  }

  String getDateTime(){
    if (this.dateTime == null){
      return "-";
    } else{
      final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(this.dateTime);
      final DateFormat formatter = DateFormat('dd.MM.yyyy, hh:mm');
      final String formatted = formatter.format(dateTime);
      return formatted;
    }
  }
}
