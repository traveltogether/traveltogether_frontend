import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/user_service.dart';
import 'package:traveltogether_frontend/widgets/button.dart';
import 'package:traveltogether_frontend/widgets/text_input.dart';

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
  String profilePic;
  String password;

  EditProfilePageState() {
    userService.getCurrentUser().then(
          (currentUser) => setState(() {
            setState(() {
              username = currentUser.username;
              firstName = currentUser.firstName;
              email = currentUser.mail;
              disabilities = currentUser.disabilities;
              if(disabilities==null) disabilities = "";
              profilePic = currentUser.profileImage;
            });
          }),
        );
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController _controllerFirstName;
  TextEditingController _controllerEmail;
  TextEditingController _controllerDisabilities;
  TextEditingController _controllerProfilePic;

  TextEditingController _controllerOldPassword;
  TextEditingController _controllerNewPassword;

  @override
  void initState() {
    super.initState();
    _controllerFirstName = new TextEditingController();
    _controllerEmail = new TextEditingController();
    _controllerOldPassword = new TextEditingController();
    _controllerNewPassword = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil bearbeiten"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
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
                      child: Padding(
                        padding: EdgeInsets.only(top: 90, left: 105),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.black54,
                          //child: Padding(padding: EdgeInsets.only(top: 35, left: 40),
                          child: IconButton(
                            iconSize: 25.0,
                            icon: Icon(Icons.upload_outlined,
                                color: Colors.white),
                            onPressed: () {
                              //Upload Profile Pic
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Container(
                    width: 350,
                    height: 45,
                    child: Button("username: "+this.username, customTextColor: Colors.black54, customTextScale: 1.1,),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Container(
                    child: TextInput(
                        this.firstName, Icons.person, _controllerFirstName)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Container(
                    child: TextInput(this.email, Icons.mail, _controllerEmail)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Container(
                    child: TextInput(this.disabilities,
                        Icons.accessible_rounded, _controllerDisabilities)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Container(
                    child: TextInput(
                  "altes Passwort",
                  Icons.lock,
                  _controllerOldPassword,
                  isObscure: true,
                )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Container(
                    child: TextInput(
                      "neues Passwort",
                      Icons.lock,
                      _controllerNewPassword,
                      isObscure: true,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
