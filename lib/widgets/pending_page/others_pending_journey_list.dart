import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/view-models/journey_read_view_model.dart';
import 'package:traveltogether_frontend/widgets/request_and_offer_card.dart';
import 'journey_item.dart';

class OthersPendingJourneysList extends StatelessWidget {
  final List<JourneyReadViewModel> journeys;
  final void Function() refreshParent;
  final int currentUserId;
  final bool isFirstItem;

  OthersPendingJourneysList(
      this.journeys, this.refreshParent, this.currentUserId, this.isFirstItem);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: journeys.length,
        itemBuilder: (context, index) {
          return Column(children: [
            (() {
              if (isFirstItem && index == 0) {
                return RequestAndOfferCard(
                    journeys[index], refreshParent, null, false);
              } else {
                return Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: RequestAndOfferCard(
                        journeys[index], refreshParent, null, false));
              }
            }()),
            if (journeys[index].pendingUserIds != null &&
                journeys[index].pendingUserIds.contains(currentUserId))
              JourneyItem(JourneyItemType.pendingOthersJourney, journeys[index],
                  refreshParent, null, currentUserId),
            if (journeys[index].acceptedUserIds != null &&
                journeys[index].acceptedUserIds.contains(currentUserId))
              JourneyItem(JourneyItemType.acceptedOthersJourney,
                  journeys[index], refreshParent, null, currentUserId),
            if (journeys[index].declinedUserIds != null &&
                journeys[index].declinedUserIds.contains(currentUserId))
              JourneyItem(JourneyItemType.declinedOthersJourney,
                  journeys[index], refreshParent, null, currentUserId),
          ]);
        });
  }
}
