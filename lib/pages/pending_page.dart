import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/journey_service.dart';
import 'package:traveltogether_frontend/services/user_service.dart';
import 'package:traveltogether_frontend/view-models/journey_read_view_model.dart';
import 'package:traveltogether_frontend/widgets/journey_item.dart';
import 'package:traveltogether_frontend/widgets/pending_accepted_declined_users_list.dart';
import 'package:traveltogether_frontend/widgets/request_and_offer_card.dart';

class PendingPage extends StatefulWidget {
  @override
  _PendingPageState createState() => _PendingPageState();
}

class _PendingPageState extends State<PendingPage> {
  JourneyService journeyService;
  UserService userService;
  int currentUserId;

  @override
  void initState() {
    super.initState();
    journeyService = new JourneyService();
    userService = new UserService();

    userService.getCurrentUser().then((user) {
      currentUserId = user.id;
      _refreshPage();
    });
  }

  void _refreshPage() {
    setState(() {});
  }

  void sortByDate(List<JourneyReadViewModel> journeys) {
    return journeys.sort((a, b) => (a.departureTime == null
            ? a.arrivalTime
            : a.departureTime)
        .compareTo(b.departureTime == null ? b.arrivalTime : b.departureTime));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Meine Fahrten")),
        body: FutureBuilder<List<JourneyReadViewModel>>(
            future: journeyService.getAll(),
            builder: (BuildContext context,
                AsyncSnapshot<List<JourneyReadViewModel>> snapshot) {
              if (!snapshot.hasData || currentUserId == null) {
                return Center(child: CircularProgressIndicator());
              } else {
                var journeys = <JourneyReadViewModel>[];
                var cancelledJourneys = <JourneyReadViewModel>[];
                snapshot.data.forEach((journey) {
                  if (journey.userId == currentUserId) {
                    if (!journey.cancelledByHost) {
                      journeys.add(journey);
                    } else {
                      cancelledJourneys.add(journey);
                    }
                  }
                });

                sortByDate(journeys);
                sortByDate(cancelledJourneys);

                var othersJourneys = <JourneyReadViewModel>[];
                var cancelledOthersJourneys = <JourneyReadViewModel>[];

                snapshot.data.forEach((journey) {
                  if (journey.pendingUserIds != null &&
                          journey.pendingUserIds.contains(currentUserId) ||
                      journey.acceptedUserIds != null &&
                          journey.acceptedUserIds.contains(currentUserId) ||
                      journey.declinedUserIds != null &&
                          journey.declinedUserIds.contains(currentUserId)) {
                    if (!journey.cancelledByHost) {
                      othersJourneys.add(journey);
                    } else {
                      cancelledOthersJourneys.add(journey);
                    }
                  }
                });

                sortByDate(othersJourneys);
                sortByDate(cancelledOthersJourneys);

                return Scrollbar(
                    child: ListView(shrinkWrap: true, children: [
                  ListView.builder(
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
                                    child: RequestAndOfferCard(
                                        journeys[index], _refreshPage));
                              } else {
                                return RequestAndOfferCard(
                                    journeys[index], _refreshPage);
                              }
                            }()),
                            if (journeys[index].pendingUserIds == null &&
                                journeys[index].acceptedUserIds == null &&
                                journeys[index].declinedUserIds == null)
                              JourneyItem(JourneyItemType.noRequests),
                            if (journeys[index].pendingUserIds != null)
                              PendingAcceptedDeclinedUsersList(
                                  journeys[index].pendingUserIds,
                                  journeys[index],
                                  JourneyItemType.pending,
                                  this._refreshPage),
                            if (journeys[index].acceptedUserIds != null)
                              PendingAcceptedDeclinedUsersList(
                                  journeys[index].acceptedUserIds,
                                  journeys[index],
                                  JourneyItemType.accepted,
                                  this._refreshPage),
                            if (journeys[index].declinedUserIds != null)
                              PendingAcceptedDeclinedUsersList(
                                  journeys[index].declinedUserIds,
                                  journeys[index],
                                  JourneyItemType.declined,
                                  this._refreshPage),
                          ],
                        );
                      }),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: othersJourneys.length,
                      itemBuilder: (context, index) {
                        return Column(children: [
                          (() {
                            if (journeys.length == 0 && index == 0) {
                              return RequestAndOfferCard(othersJourneys[index],
                                  _refreshPage, null, false);
                            } else {
                              return Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: RequestAndOfferCard(
                                      othersJourneys[index],
                                      _refreshPage,
                                      null,
                                      false));
                            }
                          }()),
                          if (othersJourneys[index].pendingUserIds != null &&
                              othersJourneys[index]
                                  .pendingUserIds
                                  .contains(currentUserId))
                            JourneyItem(JourneyItemType.pendingOthersJourney,
                                othersJourneys[index], _refreshPage),
                          if (othersJourneys[index].acceptedUserIds != null &&
                              othersJourneys[index]
                                  .acceptedUserIds
                                  .contains(currentUserId))
                            JourneyItem(JourneyItemType.acceptedOthersJourney,
                                othersJourneys[index], _refreshPage),
                          if (othersJourneys[index].declinedUserIds != null &&
                              othersJourneys[index]
                                  .declinedUserIds
                                  .contains(currentUserId))
                            JourneyItem(JourneyItemType.declinedOthersJourney,
                                othersJourneys[index], _refreshPage),
                        ]);
                      }),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cancelledJourneys.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            (() {
                              if (journeys.length == 0 &&
                                  othersJourneys.length == 0 &&
                                  index == 0) {
                                return RequestAndOfferCard(
                                    cancelledJourneys[index],
                                    _refreshPage,
                                    null,
                                    false);
                              } else {
                                return Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: RequestAndOfferCard(
                                        cancelledJourneys[index],
                                        _refreshPage,
                                        null,
                                        false));
                              }
                            }()),
                            JourneyItem(JourneyItemType.cancelled,
                                cancelledJourneys[index])
                          ],
                        );
                      }),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cancelledOthersJourneys.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            (() {
                              if (journeys.length == 0 &&
                                  othersJourneys.length == 0 &&
                                  cancelledJourneys == 0 &&
                                  index == 0) {
                                return RequestAndOfferCard(
                                    cancelledOthersJourneys[index],
                                    _refreshPage,
                                    null,
                                    false);
                              } else {
                                return Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: RequestAndOfferCard(
                                        cancelledOthersJourneys[index],
                                        _refreshPage,
                                        null,
                                        false));
                              }
                            }()),
                            JourneyItem(JourneyItemType.othersCancelled,
                                cancelledOthersJourneys[index])
                          ],
                        );
                      })
                ]));
              }
            }));
  }
}
