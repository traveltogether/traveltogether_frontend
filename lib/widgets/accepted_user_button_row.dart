import 'package:flutter/material.dart';

class AcceptedUserButtonRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        OutlineButton(
            onPressed: (() {
              debugPrint("hey");
            }),
            child: Text("Entfernen")),
        ElevatedButton(
            onPressed: (() {
              debugPrint("Chat");
            }),
            child: Text("Chat")),
      ],
    );
  }
}
