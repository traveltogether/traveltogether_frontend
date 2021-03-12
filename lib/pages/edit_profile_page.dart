import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/user_service.dart';
import 'package:traveltogether_frontend/widgets/button.dart';
import 'package:traveltogether_frontend/widgets/text_input.dart';

import '../widgets/pop_up.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  UserService userService = new UserService();
  String username = "";
  String firstName = "";
  String email = "";
  String disabilities = "";
  String profilePic = "";

  String oldPassword;
  String newPassword;

  bool mailIsValid = false;

  EditProfilePageState() {
    userService.getCurrentUser().then(
          (currentUser) => setState(() {
            setState(() {
              username = currentUser.username;
              firstName = currentUser.firstName;
              email = currentUser.mail;
              disabilities = currentUser.disabilities;
              if (disabilities == null) disabilities = "";
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
  TextEditingController _controllerRepeatNewPassword;

  @override
  void initState() {
    super.initState();
    _controllerFirstName = new TextEditingController();
    _controllerEmail = new TextEditingController();
    _controllerDisabilities = new TextEditingController();
    _controllerOldPassword = new TextEditingController();
    _controllerNewPassword = new TextEditingController();
    _controllerRepeatNewPassword = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil bearbeiten"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: Container(
                    width: 350,
                    height: 45,
                    child: Button(
                      "Nutzername: " + this.username,
                      customTextColor: Colors.black54,
                      customTextScale: 1.1,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: Container(
                      child: TextInput(
                          this.firstName, Icons.person, _controllerFirstName,
                          isDefaultValidatorActive: false)),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: Container(
                      child: TextInput(this.email, Icons.mail, _controllerEmail,
                          isDefaultValidatorActive: false,
                          customValidator: (value) {
                    bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value);
                    if (emailValid) {
                      mailIsValid = true;
                      return null;
                    }
                    if (_controllerEmail.text.length < 1)
                      return null;
                    else {
                      _controllerEmail.text = null;
                      return "ungültige Emailadresse";
                    }
                  })),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: Container(
                      child: TextInput(this.disabilities,
                          Icons.accessible_rounded, _controllerDisabilities,
                          isDefaultValidatorActive: false)),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: Container(
                      child: TextInput(
                    "altes Passwort",
                    Icons.lock,
                    _controllerOldPassword,
                    isObscure: true,
                    isDefaultValidatorActive: false,
                  )),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: Container(
                      child: TextInput(
                          "neues Passwort", Icons.lock, _controllerNewPassword,
                          isDefaultValidatorActive: false,
                          isObscure: true, customValidator: (value) {
                    if (_controllerNewPassword.text.length >= 8) {
                      return null;
                    }
                    if (_controllerNewPassword.text.length <= 1)
                      return null;
                    else {
                      return "Passwort benötigt mindestens 8 Zeichen";
                    }
                  })),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: Container(
                      child: TextInput("neues Passwort bestätigen", Icons.lock,
                          _controllerRepeatNewPassword,
                          isDefaultValidatorActive: false,
                          isObscure: true, customValidator: (value) {
                    if (_controllerRepeatNewPassword.text.length >= 8) {
                      return null;
                    }
                    if (_controllerNewPassword.text.length <= 1) return null;
                    if (_controllerNewPassword.text !=
                        _controllerRepeatNewPassword.text) {
                      return "Passwort muss gleich sein";
                    } else {
                      return "Passwort benötigt mindestens 8 Zeichen";
                    }
                  })),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: Container(
                    child: ElevatedButton(
                        child: Text("Änderungen speichern"),
                        onPressed: () async {
                          var responses = <String>[];
                          if (_formKey.currentState.validate()) print("valide");
                          if (_controllerNewPassword.text ==
                                  _controllerRepeatNewPassword.text &&
                              _controllerNewPassword.text.length >= 8) {
                            this.oldPassword = _controllerOldPassword.text;
                            this.newPassword = _controllerNewPassword.text;
                            if (_controllerNewPassword.text.length >= 8)
                              await userService
                                  .changePassword(oldPassword, newPassword)
                                  .then((value) {
                                responses.add(value["error"]);
                              });
                          }

                          if (_controllerFirstName.text.length >= 4)
                            await userService
                                .changeFirstname(_controllerFirstName.text)
                                .then((response) {
                              responses.add(response["error"]);
                            });
                          if (_controllerDisabilities.text.length >= 1)
                            await userService
                                .changeDisability(_controllerDisabilities.text)
                                .then((response) {
                              responses.add(response["error"]);
                            });
                          if (mailIsValid)
                            await userService
                                .changeMail(_controllerEmail.text)
                                .then((response) {
                              responses.add(response["error"]);
                            });

                          var errorsOccured = <String>[];
                          responses.forEach((res) {
                            if (res != null) {
                              errorsOccured.add(res);
                            }
                          });

                          if (errorsOccured.length == 0) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return PopUp(
                                  "Profil ändern",
                                  "Profil wurde angepasst!",
                                );
                              },
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return PopUp(
                                  "Fehler",
                                  "Es ist ein Fehler aufgetreten." +
                                      "\n\nBitte kontaktiere den Support.",
                                  isWarning: true,
                                );
                              },
                            );
                          }
                        }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
