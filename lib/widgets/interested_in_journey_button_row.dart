import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/journey_service.dart';
import 'package:traveltogether_frontend/services/user_service.dart';
import 'package:traveltogether_frontend/view-models/journey_read_view_model.dart';
import 'chat_button.dart';

class InterestedInJourneyButtonRow extends StatefulWidget {
  final JourneyReadViewModel journey;
  final int currentUserId;
  final bool isInterestedInButtonDisabled;
  final void Function() refreshParent;

  InterestedInJourneyButtonRow(this.currentUserId, this.journey, this.refreshParent,
      this.isInterestedInButtonDisabled);

  @override
  _InterestedInJourneyButtonRowState createState() =>
      _InterestedInJourneyButtonRowState(this.currentUserId);
}

class _InterestedInJourneyButtonRowState
    extends State<InterestedInJourneyButtonRow> {
  JourneyService journeyService;
  UserService userService = new UserService();
  String userName = "";

  _InterestedInJourneyButtonRowState(id) {
    userService.getUser(id).then(
      (value) => setState(() {
        setState(() {
          userName = value.username;
        });
      }),
    );
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton(
            onPressed: widget.isInterestedInButtonDisabled
                ? null
                : (() {
                    this
                        .journeyService
                        .joinJourney(widget.journey.id)
                        .then((response) {
                      if (response["error"] == null) {
                        widget.refreshParent();
                      } else {
                        debugPrint(response["error"]);
                      }
                    });
                  }),
            child: Text("Interessiert mich")),
        ChatButton(widget.journey.userId, userName),
      ],
    );
  }
}
