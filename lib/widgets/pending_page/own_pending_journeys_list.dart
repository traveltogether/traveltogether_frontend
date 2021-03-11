import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/view-models/journey_read_view_model.dart';
import 'package:traveltogether_frontend/widgets/pending_accepted_declined_users_list.dart';
import 'package:traveltogether_frontend/widgets/pending_page/journey_item.dart';
import 'package:traveltogether_frontend/widgets/request_and_offer_card.dart';

class OwnPendingJourneysList extends StatelessWidget {
  final List<JourneyReadViewModel> journeys;
  final void Function() refreshParent;

  OwnPendingJourneysList(this.journeys, this.refreshParent);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: journeys.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              (() {
                if (index != 0) {
                  return Padding(
                      padding: EdgeInsets.only(top: 10),
                      child:
                          RequestAndOfferCard(journeys[index], refreshParent));
                } else {
                  return RequestAndOfferCard(journeys[index], refreshParent);
                }
              }()),
              if (journeys[index].pendingUserIds == null &&
                  journeys[index].acceptedUserIds == null &&
                  journeys[index].declinedUserIds == null)
                JourneyItem(JourneyItemType.noRequests),
              if (journeys[index].pendingUserIds != null)
                PendingAcceptedDeclinedUsersList(journeys[index].pendingUserIds,
                    journeys[index], JourneyItemType.pending, refreshParent),
              if (journeys[index].acceptedUserIds != null)
                PendingAcceptedDeclinedUsersList(
                    journeys[index].acceptedUserIds,
                    journeys[index],
                    JourneyItemType.accepted,
                    refreshParent),
              if (journeys[index].declinedUserIds != null)
                PendingAcceptedDeclinedUsersList(
                    journeys[index].declinedUserIds,
                    journeys[index],
                    JourneyItemType.declined,
                    refreshParent),
            ],
          );
        });
  }
}
