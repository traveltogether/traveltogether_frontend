import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        body: Center(child: Text("Hello World!")));
  }
}
