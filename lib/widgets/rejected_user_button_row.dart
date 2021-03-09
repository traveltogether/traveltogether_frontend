import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/journey_service.dart';
import 'package:traveltogether_frontend/widgets/pop_up.dart';

class RejectedUserButtonRow extends StatelessWidget {
  final int journeyId;
  final int userId;
  final void Function() refreshParent;
  JourneyService journeyService;

  RejectedUserButtonRow(this.journeyId, this.userId, this.refreshParent) {
    this.journeyService = new JourneyService();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        OutlineButton(
            onPressed: (() {
              journeyService
                  .reverseRejectionOfUser(journeyId, userId)
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
            child: Text("Absage aufheben")),
        ElevatedButton(
            onPressed: (() {
              debugPrint("Chat");
            }),
            child: Text("Chat")),
      ],
    );
  }
}