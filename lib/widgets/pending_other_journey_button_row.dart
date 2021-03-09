import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/journey_service.dart';
import 'package:traveltogether_frontend/widgets/pop_up.dart';

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
        OutlinedButton(
            onPressed: (() {
              journeyService.leaveJourney(journeyId).then((response) {
                if (response["error"] == null) {
                  refreshParent();
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return PopUp(
                        "Fehler",
                        response["error"] +
                            "\n\nBitte kontaktiere den Support.",
                        isWarning: true,
                      );
                    },
                  );
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
