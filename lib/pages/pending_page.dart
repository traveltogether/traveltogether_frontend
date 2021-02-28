import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/widgets/journey_item.dart';

class PendingPage extends StatefulWidget {
  @override
  _PendingPageState createState() => _PendingPageState();
}

class _PendingPageState extends State<PendingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Meine Fahrten")),
        body: Column(
          children: [
            JourneyItem("User x interessiert sich für diese Fahrt!"),
          ],
        ));
  }
}
