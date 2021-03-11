import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/journey_service.dart';
import 'package:traveltogether_frontend/services/user_service.dart';
import 'package:traveltogether_frontend/types/journey_lists.dart';
import 'package:traveltogether_frontend/view-models/journey_read_view_model.dart';
import 'file:///C:/Users/admin/Documents/FH/SWE_II/traveltogether/traveltogether_frontend/lib/widgets/pending_page/pending_journeys_list.dart';

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

  List<JourneyReadViewModel> getOffers(List<JourneyReadViewModel> journeys) {
    var offers = <JourneyReadViewModel>[];
    journeys.forEach((journey) {
      if (journey.isOffer) {
        offers.add(journey);
      }
    });
    return offers;
  }

  List<JourneyReadViewModel> getRequests(List<JourneyReadViewModel> journeys) {
    var requests = <JourneyReadViewModel>[];
    journeys.forEach((journey) {
      if (journey.isRequest) {
        requests.add(journey);
      }
    });
    return requests;
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

                var offers = new JourneyLists(
                    getOffers(journeys),
                    getOffers(othersJourneys),
                    getOffers(cancelledJourneys),
                    getOffers(cancelledOthersJourneys));

                var requests = new JourneyLists(
                    getRequests(journeys),
                    getRequests(othersJourneys),
                    getRequests(cancelledJourneys),
                    getRequests(cancelledOthersJourneys));

                return ListView(
                  children: [
                    Card(
                        margin: EdgeInsets.only(left: 7, right: 7, top: 5),
                        color: Colors.grey,
                        child: Center(
                            child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text("Angebote",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ))))),
                    PendingJourneysList(offers, currentUserId, _refreshPage),
                    Card(
                        margin: EdgeInsets.only(left: 7, right: 7, top: 5),
                        color: Colors.grey,
                        child: Center(
                            child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text("Anfragen",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))))),
                    PendingJourneysList(requests, currentUserId, _refreshPage),
                  ],
                );
              }
            }));
  }
}
