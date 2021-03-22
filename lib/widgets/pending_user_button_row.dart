import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/journey_service.dart';
import 'package:traveltogether_frontend/view-models/journey_read_view_model.dart';
import 'package:traveltogether_frontend/widgets/pop_up.dart';

import 'chat_button.dart';

class PendingUserButtonRow extends StatelessWidget {
  final JourneyReadViewModel journey;
  final int userId;
  final void Function() refreshParent;
  JourneyService journeyService;

  PendingUserButtonRow(this.journey, this.userId, this.refreshParent) {
    this.journeyService = new JourneyService();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        OutlinedButton(
            onPressed: (() {
              journeyService.acceptUser(journey.id, userId).then((response) {
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
            child: Text("Annehmen")),
        OutlinedButton(
          onPressed: (() {
            journeyService.rejectUser(journey.id, userId).then((response) {
              if (response["error"] == null) {
                refreshParent();
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return PopUp(
                      "Fehler",
                      response["error"] + "\n\nBitte kontaktiere den Support.",
                      isWarning: true,
                    );
                  },
                );
              }
            });
          }),
          child: Text("Ablehnen"),
        ),
        ChatButton(userId, journey.userId),
      ],
    );
  }
}
