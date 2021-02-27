import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/journey_service.dart';
import 'package:traveltogether_frontend/services/user_service.dart';
import 'package:traveltogether_frontend/view-models/journey_read_view_model.dart';
import 'package:traveltogether_frontend/view-models/user_read_view_model.dart';
import 'package:traveltogether_frontend/widgets/request_and_offer_card.dart';

class OffersPage extends StatefulWidget {
  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  JourneyService journeyService;
  UserService userService;
  UserReadViewModel currentUser;

  @override
  void initState() {
    super.initState();
    journeyService = new JourneyService();
    userService = new UserService();
    userService.getUser("me").then((user) => currentUser = user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Angebote"),
      ),
      body: FutureBuilder<List<JourneyReadViewModel>>(
        future: journeyService.getAll(offer: true, openForRequests: true),
        builder: (BuildContext context,
            AsyncSnapshot<List<JourneyReadViewModel>> snapshot) {
          if (!snapshot.hasData || currentUser == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            List<JourneyReadViewModel> journeys = [];
            snapshot.data.forEach((journey) {
              if (journey.userId != currentUser.id) {
                journeys.add(journey);
              }
            });
            return ListView.builder(
              itemCount: journeys.length,
              itemBuilder: (context, index) {
                return RequestAndOfferCard(journeys[index]);
              },
            );
          }
        },
      ),
    );
  }
}
