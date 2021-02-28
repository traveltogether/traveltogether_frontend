import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/journey_service.dart';

class InterestedInJourneyButtonRow extends StatefulWidget {
  final int journeyId;
  final bool isInterestedInButtonDisabled;

  InterestedInJourneyButtonRow(this.journeyId, this.isInterestedInButtonDisabled);
  @override
  _InterestedInJourneyButtonRowState createState() =>
      _InterestedInJourneyButtonRowState(journeyId, isInterestedInButtonDisabled);
}

class _InterestedInJourneyButtonRowState
    extends State<InterestedInJourneyButtonRow> {
  final int journeyId;
  final bool isInterestedInButtonDisabled;
  JourneyService journeyService;

  _InterestedInJourneyButtonRowState(
      this.journeyId, this.isInterestedInButtonDisabled);

  @override
  void initState() {
    super.initState();
    journeyService = new JourneyService();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton(
            onPressed: isInterestedInButtonDisabled
                ? null
                : (() {
                    this.journeyService.joinJourney(journeyId).then((response) {
                      if (response["error"] == null) {
                        debugPrint("success!");
                      } else {
                        debugPrint(response["error"]);
                      }
                    });
                  }),
            child: Text("Interessiert mich")),
        ElevatedButton(
          onPressed: (() {
            debugPrint("Chat button pressed");
          }),
          child: Text("Chat"),
        ),
      ],
    );
  }
}
