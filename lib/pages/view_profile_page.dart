  import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/user_service.dart';
import 'package:traveltogether_frontend/widgets/button.dart';

class ViewProfilePage extends StatefulWidget {
  ViewProfilePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  ViewProfilePageState createState() => ViewProfilePageState();
}

class ViewProfilePageState extends State<ViewProfilePage> {
  UserService userService = new UserService();
  String username;
  String firstName;
  String mail;
  String disabilities;
  int id = 4;
  double Fieldwidth = 300;
  double scale = 1.25;

  ViewProfilePageState() {
    userService.getUser(id).then(
          (currentUser) => setState(() {
            setState(() {
              username = currentUser.username;
              firstName = currentUser.firstName;
              disabilities = currentUser.disabilities;
            });
          }),
        );
  }

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
              Container(
                height: 200,
                width: double.infinity,
                margin: EdgeInsets.symmetric(),
              ),
              Positioned(
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(
                      "https://blog.wwf.de/wp-content/uploads/2019/10/pinguine.jpg"),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Container(

              width: this.Fieldwidth,
            child: Button(this.firstName, customTextScale: scale,),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Container(
              width: this.Fieldwidth,
              child: Button(this.username, customTextScale: scale,),
            ),
          ),
          Padding(

            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Container(
              width: this.Fieldwidth,
              child: Button(this.disabilities, customTextScale: this.scale,),
            ),
          ),
        ],
      ),
    );
  }
}
