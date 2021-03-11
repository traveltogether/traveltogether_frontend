import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/types/journey_lists.dart';
import 'package:traveltogether_frontend/widgets/others_cancelled_journeys_list.dart';
import 'package:traveltogether_frontend/widgets/others_pending_journeys_list.dart';
import 'package:traveltogether_frontend/widgets/own_cancelled_journeys_list.dart';
import 'own_pending_journeys_list.dart';

class PendingJourneysList extends StatelessWidget {
  final JourneyLists journeyLists;
  final int currentUserId;

  final void Function() refreshParent;

  PendingJourneysList(
      this.journeyLists, this.currentUserId, this.refreshParent);

  @override
  Widget build(BuildContext context) {
    return ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          OwnPendingJourneysList(journeyLists.journeys, refreshParent),
          OwnCancelledJourneysList(
              journeyLists.cancelledJourneys,
              refreshParent,
              currentUserId,
              journeyLists.journeys.length == 0 ? true : false),
          OthersPendingJourneysList(
              journeyLists.othersJourneys,
              refreshParent,
              journeyLists.journeys.length == 0
                  ? (journeyLists.cancelledJourneys.length == 0 ? true : false)
                  : false),
          OthersCancelledJourneysList(
              journeyLists.cancelledOthersJourneys,
              refreshParent,
              journeyLists.journeys.length == 0
                  ? (journeyLists.cancelledJourneys.length == 0
                      ? (journeyLists.othersJourneys.length == 0 ? true : false)
                      : false)
                  : false)
        ]);
  }
}
