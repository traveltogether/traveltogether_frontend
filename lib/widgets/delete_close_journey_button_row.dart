import 'package:flutter/material.dart';

class DeleteCloseJourneyButtonRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            onPressed: (() {
              debugPrint("hey");
            }),
            child: Text("Löschen")),
        OutlineButton(
            onPressed: (() {
              debugPrint("hey");
            }),
            child: Text("Für Anfragen schließen")),
      ],
    );
  }
}
