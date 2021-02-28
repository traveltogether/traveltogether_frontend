import 'package:flutter/material.dart';

class PendingUserButtonRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            onPressed: (() {
              debugPrint("hey");
            }),
            child: Text("Akzeptieren")),
        ElevatedButton(
          onPressed: (() {
            debugPrint("hey");
          }),
          child: Text("Ablehnen"),
        ),
        ElevatedButton(
            onPressed: (() {
              debugPrint("hey");
            }),
            child: Text("Chat")),
      ],
    );
  }
}
