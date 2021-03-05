import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/journey_service.dart';

class PendingOthersJourneyButtonRow extends StatelessWidget {
  final int journeyId;
  final void Function() refreshParent;
  JourneyService journeyService;

  PendingOthersJourneyButtonRow(this.journeyId, this.refreshParent) {
    this.journeyService = new JourneyService();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        OutlineButton(
            onPressed: (() {
              journeyService.leaveJourney(journeyId)
                  .then((response) {
                if (response["error"] == null) {
                  refreshParent();
                } else {
                  debugPrint(response["error"]);
                }
              });
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
