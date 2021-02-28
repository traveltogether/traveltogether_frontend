import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:traveltogether_frontend/view-models/journey_read_view_model.dart';
import 'package:traveltogether_frontend/widgets/interested_in_journey_button_row.dart';
import 'accept_decline_journey_button_row.dart';
import 'address_table.dart';
import 'formatted_date_time.dart';

class RequestAndOfferCard extends StatelessWidget {
  final JourneyReadViewModel journey;
  final int currentUserId;

  RequestAndOfferCard(this.journey, [this.currentUserId]);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(7),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            (() {
              if(this.currentUserId != null) {
                return InterestedInJourneyButtonRow(this.journey.id);
              } else {
                return AcceptDeclineJourneyButtonRow();
              }
            }())
          ],
        ),
      ),
    );
  }
}
