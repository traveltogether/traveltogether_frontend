import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/journey_service.dart';
import 'package:traveltogether_frontend/view-models/journey_read_view_model.dart';
import 'package:traveltogether_frontend/widgets/pop_up.dart';

import 'chat_button.dart';

class AcceptedOthersJourneyButtonRow extends StatelessWidget {
  final JourneyReadViewModel journey;
  final int currentUserId;
  final void Function() refreshParent;
  JourneyService journeyService;

  AcceptedOthersJourneyButtonRow(this.journey, this.currentUserId, this.refreshParent) {
    this.journeyService = new JourneyService();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        OutlinedButton(
            onPressed: (() {
              journeyService
                  .cancelJourney(journey.id, "reason")
                  .then((response) {
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
            child: Text("Verlassen")),
        ChatButton(journey.userId, currentUserId),
      ],
    );
  }
}
