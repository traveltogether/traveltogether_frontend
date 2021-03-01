import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/journey_service.dart';

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
              journeyService.reverseRejectionOfUser(journeyId, userId)
                  .then((response) {
                if (response["error"] == null) {
                  refreshParent();
                } else {
                  debugPrint(response["error"]);
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
