import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/journey_service.dart';
import 'package:traveltogether_frontend/view-models/journey_read_view_model.dart';

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
              this.journeyService.deleteJourney(journey.id).then((response) {
                if (response["error"] == null) {
                  refreshParent();
                } else {
                  debugPrint(response["error"]);
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
                  debugPrint(response["error"]);
                }
              });
            }),
            child: Text(
                "Für Anfragen ${journey.isOpenForRequests ? "schließen" : "öffnen"}")),
      ],
    );
  }
}
