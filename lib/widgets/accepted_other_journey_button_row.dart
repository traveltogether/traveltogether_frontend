import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/journey_service.dart';

class AcceptedOthersJourneyButtonRow extends StatelessWidget {
  final int journeyId;
  final void Function() refreshParent;
  JourneyService journeyService;

  AcceptedOthersJourneyButtonRow(this.journeyId, this.refreshParent) {
    this.journeyService = new JourneyService();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        OutlineButton(
            onPressed: (() {
              // ToDo: show popup to give a reason
              journeyService.cancelJourney(journeyId, "reason")
                  .then((response) {
                if (response["error"] == null) {
                  refreshParent();
                } else {
                  debugPrint(response["error"]);
                }
              });
            }),
            child: Text("Verlassen")),
        ElevatedButton(
            onPressed: (() {
              debugPrint("Chat");
            }),
            child: Text("Chat")),
      ],
    );
  }
}
