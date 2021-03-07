import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/user_service.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  UserService userService = new UserService();
  String username;
  String firstName;
  String email;
  String disabilities;

  EditProfilePageState() {
    userService.getCurrentUser().then(
          (currentUser) => setState(() {
            setState(() {
              username = currentUser.username;
              firstName = currentUser.firstName;
              email = currentUser.mail;
              disabilities = currentUser.disabilities;
            });
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil bearbeiten"),
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
                    child: Padding(padding: EdgeInsets.only(top: 90, left: 105),
                      child:
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.black54,
                        //child: Padding(padding: EdgeInsets.only(top: 35, left: 40),
                        child: IconButton(
                          iconSize: 25.0,
                          icon: Icon(Icons.upload_outlined, color: Colors.white), onPressed: (){
                          //Upload Profile Pic
                        },),

                      ),

                    ),

                  ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
