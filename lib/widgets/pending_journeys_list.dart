import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/types/journey_lists.dart';
import 'package:traveltogether_frontend/widgets/pending_accepted_declined_users_list.dart';
import 'package:traveltogether_frontend/widgets/request_and_offer_card.dart';
import 'journey_item.dart';

class PendingJourneysList extends StatelessWidget {
  final JourneyLists journeyLists;
  final int currentUserId;

  final void Function() refreshParent;

  PendingJourneysList(
      this.journeyLists,
      this.currentUserId,
      this.refreshParent);

  @override
  Widget build(BuildContext context) {
    return ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: journeyLists.journeys.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    (() {
                      if (index != 0) {
                        return Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: RequestAndOfferCard(
                                journeyLists.journeys[index], refreshParent));
                      } else {
                        return RequestAndOfferCard(
                            journeyLists.journeys[index], refreshParent);
                      }
                    }()),
                    if (journeyLists.journeys[index].pendingUserIds == null &&
                        journeyLists.journeys[index].acceptedUserIds == null &&
                        journeyLists.journeys[index].declinedUserIds == null)
                      JourneyItem(JourneyItemType.noRequests),
                    if (journeyLists.journeys[index].pendingUserIds != null)
                      PendingAcceptedDeclinedUsersList(
                          journeyLists.journeys[index].pendingUserIds,
                          journeyLists.journeys[index],
                          JourneyItemType.pending,
                          refreshParent),
                    if (journeyLists.journeys[index].acceptedUserIds != null)
                      PendingAcceptedDeclinedUsersList(
                          journeyLists.journeys[index].acceptedUserIds,
                          journeyLists.journeys[index],
                          JourneyItemType.accepted,
                          refreshParent),
                    if (journeyLists.journeys[index].declinedUserIds != null)
                      PendingAcceptedDeclinedUsersList(
                          journeyLists.journeys[index].declinedUserIds,
                          journeyLists.journeys[index],
                          JourneyItemType.declined,
                          refreshParent),
                  ],
                );
              }),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: journeyLists.othersJourneys.length,
              itemBuilder: (context, index) {
                return Column(children: [
                  (() {
                    if (journeyLists.journeys.length == 0 && index == 0) {
                      return RequestAndOfferCard(
                          journeyLists.othersJourneys[index], refreshParent, null, false);
                    } else {
                      return Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: RequestAndOfferCard(journeyLists.othersJourneys[index],
                              refreshParent, null, false));
                    }
                  }()),
                  if (journeyLists.othersJourneys[index].pendingUserIds != null &&
                      journeyLists.othersJourneys[index]
                          .pendingUserIds
                          .contains(currentUserId))
                    JourneyItem(JourneyItemType.pendingOthersJourney,
                        journeyLists.othersJourneys[index], refreshParent),
                  if (journeyLists.othersJourneys[index].acceptedUserIds != null &&
                      journeyLists.othersJourneys[index]
                          .acceptedUserIds
                          .contains(currentUserId))
                    JourneyItem(
                        JourneyItemType.acceptedOthersJourney,
                        journeyLists.othersJourneys[index],
                        refreshParent,
                        null,
                        currentUserId),
                  if (journeyLists.othersJourneys[index].declinedUserIds != null &&
                      journeyLists.othersJourneys[index]
                          .declinedUserIds
                          .contains(currentUserId))
                    JourneyItem(
                        JourneyItemType.declinedOthersJourney,
                        journeyLists.othersJourneys[index],
                        refreshParent,
                        null,
                        currentUserId),
                ]);
              }),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: journeyLists.cancelledJourneys.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    (() {
                      if (journeyLists.journeys.length == 0 &&
                          journeyLists.othersJourneys.length == 0 &&
                          index == 0) {
                        return RequestAndOfferCard(journeyLists.cancelledJourneys[index],
                            refreshParent, null, false);
                      } else {
                        return Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: RequestAndOfferCard(journeyLists.cancelledJourneys[index],
                                refreshParent, null, false));
                      }
                    }()),
                    JourneyItem(
                        JourneyItemType.cancelled, journeyLists.cancelledJourneys[index])
                  ],
                );
              }),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: journeyLists.cancelledOthersJourneys.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    (() {
                      if (journeyLists.journeys.length == 0 &&
                          journeyLists.othersJourneys.length == 0 &&
                          journeyLists.cancelledJourneys.length == 0 &&
                          index == 0) {
                        return RequestAndOfferCard(
                            journeyLists.cancelledOthersJourneys[index],
                            refreshParent,
                            null,
                            false);
                      } else {
                        return Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: RequestAndOfferCard(
                                journeyLists.cancelledOthersJourneys[index],
                                refreshParent,
                                null,
                                false));
                      }
                    }()),
                    JourneyItem(JourneyItemType.othersCancelled,
                        journeyLists.cancelledOthersJourneys[index])
                  ],
                );
              })
        ]);
  }
}
