import 'package:flutter/material.dart';

class InterestedInJourneyButtonRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton(
            onPressed: (() {
              debugPrint("hey");
            }),
            child: Text("Interessiert mich")),
        ElevatedButton(
          onPressed: (() {
            debugPrint("hey");
          }),
          child: Text("Chat"),
        ),
      ],
    );
  }
}
