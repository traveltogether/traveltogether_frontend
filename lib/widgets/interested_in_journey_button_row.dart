import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/journey_service.dart';

class InterestedInJourneyButtonRow extends StatefulWidget {
  final int journeyId;
  final bool isInterestedInButtonDisabled;
  final void Function() refreshParent;

  InterestedInJourneyButtonRow(
      this.journeyId, this.refreshParent, this.isInterestedInButtonDisabled);
  @override
  _InterestedInJourneyButtonRowState createState() =>
      _InterestedInJourneyButtonRowState();
}

class _InterestedInJourneyButtonRowState
    extends State<InterestedInJourneyButtonRow> {
  JourneyService journeyService;

  _InterestedInJourneyButtonRowState();

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
                        .joinJourney(widget.journeyId)
                        .then((response) {
                      if (response["error"] == null) {
                        widget.refreshParent();
                      } else {
                        debugPrint(response["error"]);
                      }
                    });
                  }),
            child: Text("Interessiert mich")),
        ElevatedButton(
          onPressed: (() {
            debugPrint("Chat");
          }),
          child: Text("Chat"),
        ),
      ],
    );
  }
}
