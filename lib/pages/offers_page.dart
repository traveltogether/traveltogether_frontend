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
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return RequestAndOfferCard(snapshot.data[index]);
              },
            );
          }
        },
      ),
    );
  }
}
