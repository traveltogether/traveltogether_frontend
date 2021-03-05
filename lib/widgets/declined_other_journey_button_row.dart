import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/journey_service.dart';

class DeclinedOthersJourneyButtonRow extends StatelessWidget {
  final void Function() refreshParent;
  JourneyService journeyService;

  DeclinedOthersJourneyButtonRow(this.refreshParent) {
    this.journeyService = new JourneyService();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
            onPressed: (() {
              debugPrint("Chat");
            }),
            child: Text("Chat")),
      ],
    );
  }
}
