import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/widgets/request_and_offer_card.dart';

class OffersPage extends StatefulWidget {
  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Angebote"),
        ),
        body: ListView(
          children: [
            RequestAndOfferCard(),
            RequestAndOfferCard(),
            RequestAndOfferCard(),
            RequestAndOfferCard(),
            RequestAndOfferCard(),
          ],
        )
    );
  }
}
