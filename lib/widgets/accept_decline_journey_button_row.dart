import 'package:flutter/material.dart';

class AcceptDeclineJourneyButtonRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: ElevatedButton(
              onPressed: (() {debugPrint("hey");}),
              child: Text("Akzeptieren")),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: ElevatedButton(
            onPressed: (() {debugPrint("hey");}),
            child: Text("Ablehnen"),
          ),
        ),
      ],
    );
  }
}
