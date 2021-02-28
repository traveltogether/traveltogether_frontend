import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:traveltogether_frontend/view-models/journey_read_view_model.dart';
import 'package:traveltogether_frontend/widgets/delete_close_journey_button_row.dart';
import 'package:traveltogether_frontend/widgets/info_box.dart';
import 'package:traveltogether_frontend/widgets/interested_in_journey_button_row.dart';
import 'pending_user_button_row.dart';
import 'address_table.dart';
import 'formatted_date_time.dart';

// ignore: must_be_immutable
class RequestAndOfferCard extends StatelessWidget {
  final JourneyReadViewModel journey;
  final int currentUserId;
  bool _isCurrentUserPending = false;
  bool _isCurrentUserAccepted = false;
  bool _isCurrentUserDeclined = false;
  final void Function() refreshParent;

  RequestAndOfferCard(this.journey, this.refreshParent, [this.currentUserId]) {
    if (journey.pendingUserIds != null &&
        journey.pendingUserIds.contains(currentUserId)) {
      _isCurrentUserPending = true;
    } else if (journey.acceptedUserIds != null &&
        journey.acceptedUserIds.contains(currentUserId)) {
      _isCurrentUserAccepted = true;
    } else if (journey.declinedUserIds != null &&
        journey.declinedUserIds.contains(currentUserId)) {
      _isCurrentUserDeclined = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(7),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(bottom: 7),
                child: AddressTable(journey.approximateStartAddress,
                    journey.approximateEndAddress)),
            Padding(
              padding: EdgeInsets.only(bottom: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text("Startzeit"),
                      FormattedDateTime(journey.departureTime),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Ankunftszeit"),
                      FormattedDateTime(journey.arrivalTime),
                    ],
                  ),
                ],
              ),
            ),
            if (journey.note != null)
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text("Notiz:\n" + journey.note),
              ),
            if (_isCurrentUserPending)
              InfoBox("Du hast diese Reise bereits angefragt", Colors.blueGrey),
            if (_isCurrentUserAccepted)
              InfoBox("Du wurdest für diese Reise angenommen", Colors.green),
            if (_isCurrentUserDeclined)
              InfoBox("Du wurdest für diese Reise abgelehnt", Colors.red),
            (() {
              if (this.currentUserId != null) {
                return InterestedInJourneyButtonRow(
                    this.journey.id,
                    refreshParent,
                    _isCurrentUserPending ||
                        _isCurrentUserAccepted ||
                        _isCurrentUserDeclined);
              } else {
                return DeleteCloseJourneyButtonRow();
              }
            }())
          ],
        ),
      ),
    );
  }
}
