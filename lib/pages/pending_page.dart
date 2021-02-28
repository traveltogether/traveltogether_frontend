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

            // cases:
            // pending user
            JourneyItem(JourneyItemType.pending),
            // accepted user
            JourneyItem(JourneyItemType.accepted),
            // rejected user
            JourneyItem(JourneyItemType.rejected),

            //ToDo: Journey BR - delete, closeForRequests
            //ToDo: User BR - accept, decline, chat
            //ToDo: accepted User BR - remove, chat
            //ToDo: rejected User BR - reverse rejection

          ],
        ));
  }
}
