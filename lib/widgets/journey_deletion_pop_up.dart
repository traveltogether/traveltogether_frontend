import 'package:flutter/material.dart';

class JourneyDeletionPopUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Fahrt löschen",
        style: TextStyle(color: Colors.red),
      ),
      content: Text(
        "Möchetest du diese Fahrt wirklich löschen?",
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      actions: [
        TextButton(
          child: Text(
            "Abbrechen",
            style: TextStyle(color: Colors.blueAccent),
          ),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        TextButton(
          child: Text(
            "Löschen",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }
}
