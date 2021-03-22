import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/journey_service.dart';
import 'package:traveltogether_frontend/types/journey_lists.dart';
import 'package:traveltogether_frontend/view-models/journey_read_view_model.dart';
import 'package:traveltogether_frontend/widgets/anonymized_address_info.dart';
import 'package:traveltogether_frontend/widgets/pending_page/pending_journeys_list.dart';

class PendingPage extends StatefulWidget {
  final int currentUserId;

  PendingPage(this.currentUserId);

  @override
  _PendingPageState createState() => _PendingPageState();
}

class _PendingPageState extends State<PendingPage> {
  JourneyService journeyService = new JourneyService();

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
              if (!snapshot.hasData || widget.currentUserId == null) {
                return Center(child: CircularProgressIndicator());
              } else {
                var journeys = <JourneyReadViewModel>[];
                var cancelledJourneys = <JourneyReadViewModel>[];
                snapshot.data.forEach((journey) {
                  if (journey.userId == widget.currentUserId) {
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
                          journey.pendingUserIds
                              .contains(widget.currentUserId) ||
                      journey.acceptedUserIds != null &&
                          journey.acceptedUserIds
                              .contains(widget.currentUserId) ||
                      journey.declinedUserIds != null &&
                          journey.declinedUserIds
                              .contains(widget.currentUserId)) {
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
                    AnonymizedAddressInfo(),
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
                    PendingJourneysList(
                        offers, widget.currentUserId, _refreshPage),
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
                    PendingJourneysList(
                        requests, widget.currentUserId, _refreshPage),
                  ],
                );
              }
            }));
  }
}
