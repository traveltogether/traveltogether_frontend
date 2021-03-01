import 'package:flutter/material.dart';

class PendingUserButtonRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        OutlineButton(
            onPressed: (() {
              debugPrint("hey");
            }),
            child: Text("Annehmen")),
        OutlineButton(
          onPressed: (() {
            debugPrint("hey");
          }),
          child: Text("Ablehnen"),
        ),
        ElevatedButton(
            onPressed: (() {
              debugPrint("Chat");
            }),
            child: Text("Chat")),
      ],
    );
  }
}