import 'dart:io';

import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/journey_service.dart';
import 'package:traveltogether_frontend/view-models/user_read_view_model.dart';

class PendingUserButtonRow extends StatelessWidget {
  final int journeyId;
  final int userId;
  final void Function() refreshParent;
  JourneyService journeyService;

  PendingUserButtonRow(this.journeyId, this.userId, this.refreshParent) {
    this.journeyService = new JourneyService();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        OutlineButton(
            onPressed: (() {
              journeyService.acceptUser(journeyId, userId)
                  .then((response) {
                    if (response["error"] == null) {
                      refreshParent();
                    } else {
                      debugPrint(response["error"]);
                    }
              });
            }),
            child: Text("Annehmen")),
        OutlineButton(
          onPressed: (() {
            journeyService.rejectUser(journeyId, userId)
                .then((response) {
              if (response["error"] == null) {
                refreshParent();
              } else {
                debugPrint(response["error"]);
              }
            });
          }),
          child: Text("Ablehnen"),
        ),
        ElevatedButton(
            onPressed: (() {
              debugPrint("Chat");
            }),
            child: Text("Chat")),
      ],
    );
  }
}
