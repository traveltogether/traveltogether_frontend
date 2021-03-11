import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:traveltogether_frontend/view-models/journey_read_view_model.dart';
import 'package:traveltogether_frontend/widgets/delete_close_journey_button_row.dart';
import 'package:traveltogether_frontend/widgets/info_box.dart';
import 'package:traveltogether_frontend/widgets/interested_in_journey_button_row.dart';
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
  final bool showDeleteCloseButtons;

  RequestAndOfferCard(this.journey, this.refreshParent,
      [this.currentUserId, this.showDeleteCloseButtons = true]) {
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
      margin: EdgeInsets.only(left: 7, right: 7, top: 5),
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
              InfoBox("Du hast diese Fahrt bereits angefragt", Colors.blueGrey),
            if (_isCurrentUserAccepted)
              InfoBox("Du wurdest für diese Fahrt angenommen", Colors.green),
            if (_isCurrentUserDeclined)
              InfoBox("Du wurdest für diese Fahrt abgelehnt", Colors.red),
            (() {
              if (this.currentUserId != null) {
                return InterestedInJourneyButtonRow(
                    this.journey.id,
                    refreshParent,
                    _isCurrentUserPending ||
                        _isCurrentUserAccepted ||
                        _isCurrentUserDeclined);
              } else if (showDeleteCloseButtons) {
                return DeleteCloseJourneyButtonRow(journey, refreshParent);
              } else {
                // yes, this is an empty widget. It is needed as otherwise there
                // would be an error, because a widget has to be returned to the column
                return SizedBox.shrink();
              }
            }())
          ],
        ),
      ),
    );
  }
}
