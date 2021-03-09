import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/journey_service.dart';
import 'package:traveltogether_frontend/view-models/journey_read_view_model.dart';
import 'package:traveltogether_frontend/widgets/pop_up.dart';

import 'cancel_journey_pop_up.dart';

class DeleteCloseJourneyButtonRow extends StatelessWidget {
  final JourneyReadViewModel journey;
  final void Function() refreshParent;
  bool isDeletable;
  JourneyService journeyService;

  DeleteCloseJourneyButtonRow(this.journey, this.refreshParent) {
    this.journeyService = new JourneyService();
    if (journey.pendingUserIds == null &&
        journey.acceptedUserIds == null) {
      isDeletable = true;
    } else {
      isDeletable = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            onPressed: (() {
              if (!isDeletable) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CancelJourneyPopUp();
                  },
                ).then((reason) {
                  print(reason);
                  this
                      .journeyService
                      .cancelJourney(journey.id, reason)
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
                });
              } else {
                this.journeyService.deleteJourney(journey.id).then((response) {
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
              }
            }),
            child: Text(isDeletable ? "Löschen" : "Absagen")),
        OutlinedButton(
            onPressed: (() {
              this
                  .journeyService
                  .changeJourneyState(journey.id, !journey.isOpenForRequests)
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
            child: Text(
                "Für Anfragen ${journey.isOpenForRequests ? "schließen" : "öffnen"}")),
      ],
    );
  }
}
