import 'package:flutter/material.dart';


class ViewProfilePage extends StatefulWidget {
  ViewProfilePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  ViewProfilePageState createState() => ViewProfilePageState();
}

class ViewProfilePageState extends State<ViewProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Profil"),
    ),
      body: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                child: CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(
                    "https://blog.wwf.de/wp-content/uploads/2019/10/pinguine.jpg"),
              ),
              )
            ],
          )
          
        ],
      ),
    );
  }
}