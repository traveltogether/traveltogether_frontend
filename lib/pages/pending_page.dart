import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/journey_service.dart';
import 'package:traveltogether_frontend/services/user_service.dart';
import 'package:traveltogether_frontend/view-models/journey_read_view_model.dart';
import 'package:traveltogether_frontend/view-models/user_read_view_model.dart';
import 'package:traveltogether_frontend/widgets/journey_item.dart';
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
    });
  }

  void _refreshPage() {
    setState(() {});
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
                var journeys = new List<JourneyReadViewModel>();
                snapshot.data.forEach((journey) {
                  if (journey.userId == currentUserId) {
                    journeys.add(journey);
                  }
                  journeys.sort((a, b) => (a.departureTime == null
                          ? a.arrivalTime
                          : a.departureTime)
                      .compareTo(b.departureTime == null
                          ? b.arrivalTime
                          : b.departureTime));
                });

                return ListView.builder(
                    itemCount: journeys.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          (() {
                            if (index != 0) {
                              return Padding(
                                  padding: EdgeInsets.only(top: 15),
                                  child: RequestAndOfferCard(
                                      journeys[index], _refreshPage));
                            } else {
                              return RequestAndOfferCard(
                                  journeys[index], _refreshPage);
                            }
                          }()),
                          if (journeys[index].pendingUserIds != null)
                            (() {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      journeys[index].pendingUserIds.length,
                                  itemBuilder: (context, jndex) {
                                    return FutureBuilder<UserReadViewModel>(
                                        future: userService.getUser(
                                            journeys[index]
                                                .pendingUserIds[jndex]),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<UserReadViewModel>
                                                snapshot2) {
                                          if (!snapshot2.hasData) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else {
                                            return JourneyItem(
                                                JourneyItemType.pending,
                                                journeys[index].id,
                                                snapshot2.data,
                                                _refreshPage);
                                          }
                                        });
                                  });
                            }()),
                          if (journeys[index].acceptedUserIds != null)
                            (() {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      journeys[index].acceptedUserIds.length,
                                  itemBuilder: (context, jndex) {
                                    return FutureBuilder<UserReadViewModel>(
                                        future: userService.getUser(
                                            journeys[index]
                                                .acceptedUserIds[jndex]),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<UserReadViewModel>
                                                snapshot2) {
                                          if (!snapshot2.hasData) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else {
                                            return JourneyItem(
                                                JourneyItemType.accepted,
                                                journeys[index].id,
                                                snapshot2.data,
                                                _refreshPage);
                                          }
                                        });
                                  });
                            }()),
                          if (journeys[index].declinedUserIds != null)
                            (() {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      journeys[index].declinedUserIds.length,
                                  itemBuilder: (context, jndex) {
                                    return FutureBuilder<UserReadViewModel>(
                                        future: userService.getUser(
                                            journeys[index]
                                                .declinedUserIds[jndex]),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<UserReadViewModel>
                                                snapshot2) {
                                          if (!snapshot2.hasData) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else {
                                            return JourneyItem(
                                                JourneyItemType.declined,
                                                journeys[index].id,
                                                snapshot2.data,
                                                _refreshPage);
                                          }
                                        });
                                  });
                            }()),
                        ],
                      );
                    });
              }
            })

        //ToDo: Journey BR - delete, closeForRequests
        //ToDo: User BR - accept, decline, chat
        //ToDo: accepted User BR - remove, chat
        //ToDo: rejected User BR - reverse rejection

        );
  }
}
