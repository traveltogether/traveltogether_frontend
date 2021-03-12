import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/pages/register_page.dart';
import '../widgets/pop_up.dart';
import '../widgets/text_input.dart';
import 'package:traveltogether_frontend/services/user_service.dart';

import 'main.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  String name;
  String password;
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  bool check;
  UserService userService = new UserService();

  final _formKey = GlobalKey<FormState>();

  TextEditingController _controllerName;
  TextEditingController _controllerPassword;

  @override
  void initState() {
    super.initState();
    _controllerName = new TextEditingController();
    _controllerPassword = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("Login"),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: _autoValidate,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 170),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
                        child: TextInput("Username oder Email", Icons.person,
                            _controllerName)),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
                        child: TextInput(
                            "Passwort", Icons.lock, _controllerPassword,
                            isObscure: true)),
                    SizedBox(height: 120),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: ElevatedButton(
                            child: Text('Login'),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                userService
                                    .login(_controllerName.text,
                                        _controllerPassword.text)
                                    .then((response) {
                                  if (response["error"] == null) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return PopUp("Login",
                                              "Du wurdest erfolgreich eingeloggt!");
                                        }).then((_) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MyHomePage()));
                                    });
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return PopUp(
                                              "Fehler",
                                              response["error"] +
                                                  "Bitte prüfe dein Passwort und Nutzernamen.",
                                              isWarning: true);
                                        });
                                  }
                                });
                              } else {
                                setState(() {
                                  _autoValidate =
                                      AutovalidateMode.onUserInteraction;
                                });
                              }
                            })),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: ElevatedButton(
                      child: Text('Registrieren'),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()));

                        }
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
