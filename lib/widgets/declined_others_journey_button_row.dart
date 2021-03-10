import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/view-models/journey_read_view_model.dart';

class DeclinedOthersJourneyButtonRow extends StatelessWidget {
  final JourneyReadViewModel journey;
  final int currentUserId;
  final void Function() refreshParent;

  const DeclinedOthersJourneyButtonRow(
      this.journey, this.currentUserId, this.refreshParent);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
            onPressed: (() {
              debugPrint("Chat");
            }),
            child: Text("Chat")),
      ],
    );
  }
}
