import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/journey_service.dart';
import 'package:traveltogether_frontend/view-models/journey_read_view_model.dart';
import 'package:traveltogether_frontend/widgets/request_and_offer_card.dart';

class OffersPage extends StatefulWidget {
  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  JourneyService journeyService;
  JourneyReadViewModel journey;

  @override
  void initState() {
    super.initState();
    journeyService = new JourneyService();
    journeyService.getJourney(1).then((journey) {
      this.journey = journey;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Angebote"),
      ),
      body: FutureBuilder<JourneyReadViewModel>(
        future: journeyService.getJourney(1),
        builder: (BuildContext context,
            AsyncSnapshot<JourneyReadViewModel> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView(
              children: [
                RequestAndOfferCard(snapshot.data),
              ],
            );
          }
        },
      ),
    );
  }
}
