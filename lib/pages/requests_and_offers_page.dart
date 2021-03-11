import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/journey_service.dart';
import 'package:traveltogether_frontend/view-models/journey_read_view_model.dart';
import 'package:traveltogether_frontend/view-models/user_read_view_model.dart';
import 'package:traveltogether_frontend/widgets/anonymizedAddressInfo.dart';
import 'package:traveltogether_frontend/widgets/request_and_offer_card.dart';
import '../view-models/user_read_view_model.dart';

class RequestsAndOffersPage extends StatefulWidget {
  final String pageType;
  final UserReadViewModel currentUser;

  RequestsAndOffersPage(this.pageType, this.currentUser);

  @override
  _RequestsAndOffersPageState createState() => _RequestsAndOffersPageState();
}

class _RequestsAndOffersPageState extends State<RequestsAndOffersPage> {
  JourneyService journeyService = new JourneyService();

  _refreshPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pageType == "requests" ? "Anfragen" : "Angebote"),
      ),
      body: FutureBuilder<List<JourneyReadViewModel>>(
        future: journeyService.getAll(
          openForRequests: true,
          offer: widget.pageType == "offers" ? true : null,
          request: widget.pageType == "requests" ? true : null,
        ),
        builder: (BuildContext context,
            AsyncSnapshot<List<JourneyReadViewModel>> snapshot) {
          if ((!snapshot.hasData || widget.currentUser == null)) {
            return Center(child: CircularProgressIndicator());
          } else {
            List<JourneyReadViewModel> journeys = [];
            snapshot.data.forEach((journey) {
              if (journey.userId != widget.currentUser.id) {
                journeys.add(journey);
              }
              journeys.sort((a, b) =>
                  (a.departureTime == null ? a.arrivalTime : a.departureTime)
                      .compareTo(b.departureTime == null
                          ? b.arrivalTime
                          : b.departureTime));
            });
            return ListView(children: [
              AnonymizedAddressInfo(),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: journeys.length,
                itemBuilder: (context, index) {
                  return RequestAndOfferCard(
                      journeys[index], _refreshPage, widget.currentUser.id);
                },
              )
            ]);
          }
        },
      ),
    );
  }
}
