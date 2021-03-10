import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/journey_service.dart';
import 'package:traveltogether_frontend/services/user_service.dart';
import 'package:traveltogether_frontend/view-models/journey_read_view_model.dart';
import 'package:traveltogether_frontend/widgets/pop_up.dart';

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
      _InterestedInJourneyButtonRowState();
}

class _InterestedInJourneyButtonRowState
    extends State<InterestedInJourneyButtonRow> {
  JourneyService journeyService;
  UserService userService = new UserService();
  String userName = "";

  _InterestedInJourneyButtonRowState() {
    userService.getUser(widget.journey.userId).then(
      (value) => setState(() {
        setState(() {
          userName = value.username;
        });
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    journeyService = new JourneyService();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            child: Text("Interessiert mich")),
        ChatButton(widget.journey.userId, userName),
      ],
    );
  }
}
