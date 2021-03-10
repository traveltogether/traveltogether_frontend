import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/journey_service.dart';
import 'package:traveltogether_frontend/services/user_service.dart';
import 'package:traveltogether_frontend/view-models/journey_read_view_model.dart';
import 'package:traveltogether_frontend/view-models/user_read_view_model.dart';
import 'package:traveltogether_frontend/widgets/request_and_offer_card.dart';


class RequestsAndOffersPage extends StatefulWidget {
  //ToDo: final UserReadViewModel user;
  final String pageType;

  const RequestsAndOffersPage(this.pageType, {Key key}) : super(key: key);

  @override
  _RequestsAndOffersPageState createState() => _RequestsAndOffersPageState();
}

class _RequestsAndOffersPageState extends State<RequestsAndOffersPage> {
  JourneyService journeyService;
  UserService userService;
  UserReadViewModel currentUser;

  @override
  void initState() {
    super.initState();
    journeyService = new JourneyService();
    userService = new UserService();
    userService.getCurrentUser().then((user) {
      currentUser = user;
      _refreshPage();
    });
  }

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
          if ((!snapshot.hasData || currentUser == null)) {
            return Center(child: CircularProgressIndicator());
          } else {
            List<JourneyReadViewModel> journeys = [];
            snapshot.data.forEach((journey) {
              if (journey.userId != currentUser.id) {
                journeys.add(journey);
              }
              journeys.sort((a, b) =>
                  (a.departureTime == null ? a.arrivalTime : a.departureTime)
                      .compareTo(b.departureTime == null
                          ? b.arrivalTime
                          : b.departureTime));
            });
            return ListView.builder(
              itemCount: journeys.length,
              itemBuilder: (context, index) {
                return RequestAndOfferCard(
                    journeys[index], _refreshPage, currentUser.id);
              },
            );
          }
        },
      ),
    );
  }
}
