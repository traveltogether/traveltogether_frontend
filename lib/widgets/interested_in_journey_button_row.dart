import 'package:flutter/material.dart';

class InterestedInJourneyButtonRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: OutlinedButton(
              onPressed: (() {debugPrint("hey");}),
              child: Text("Interessiert mich")),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: ElevatedButton(
            onPressed: (() {debugPrint("hey");}),
            child: Text("Chat"),
          ),
        ),
      ],
    );
  }
}
