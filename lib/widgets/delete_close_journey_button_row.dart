import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/journey_service.dart';
import 'package:traveltogether_frontend/view-models/journey_read_view_model.dart';
import 'package:traveltogether_frontend/widgets/pop_up.dart';

class DeleteCloseJourneyButtonRow extends StatelessWidget {
  final JourneyReadViewModel journey;
  final void Function() refreshParent;
  JourneyService journeyService;

  DeleteCloseJourneyButtonRow(this.journey, this.refreshParent) {
    this.journeyService = new JourneyService();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            onPressed: (() {
              this
                  .journeyService
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
            child: Text("Löschen")),
        OutlineButton(
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
