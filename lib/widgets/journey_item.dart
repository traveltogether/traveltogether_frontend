import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/widgets/accept_decline_journey_button_row.dart';

class JourneyItem extends StatelessWidget {
  final String text;

  JourneyItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(7),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Icon(Icons.subdirectory_arrow_right),
                Expanded(
                    child: Center(
                        child: Column(children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(text),
                  ),
                  AcceptDeclineJourneyButtonRow(),
                ])))
              ],
            )));
  }
}
