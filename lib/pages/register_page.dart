import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/view-models/user_write_view_model.dart';
import '../widgets/text_input.dart';
import 'package:traveltogether_frontend/services/user_service.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  var user = new UserWriteViewModel();
  UserService userService = new UserService();

  bool mailIsValid;
  String password;
  String passwordRepeat;

  final _formKey = GlobalKey<FormState>();

  TextEditingController _controllerNickname;
  TextEditingController _controllerFirstName;
  TextEditingController _controllerEmail;
  TextEditingController _controllerPassword;
  TextEditingController _controllerRepeatPassword;

  @override
  void initState() {
    super.initState();
    _controllerNickname = new TextEditingController();
    _controllerFirstName = new TextEditingController();
    _controllerEmail = new TextEditingController();
    _controllerPassword = new TextEditingController();
    _controllerRepeatPassword = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registrierung"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: <
                    Widget>[
              Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextInput("Email", Icons.email, _controllerEmail,
                      customValidator: (value) {
                    bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value);
                    if (emailValid) {
                      mailIsValid = true;
                      return null;
                    } else {
                      _controllerEmail.text = null;
                      return "ungültige Emailadresse";
                    }
                  })),
              Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextInput(
                      "Nutzername", Icons.person, _controllerNickname)),
              Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextInput(
                      "Vorname", Icons.person_outline, _controllerFirstName)),
              Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextInput("Passwort", Icons.lock, _controllerPassword, isPassword: true,
                      customValidator: (value) {
                    if (_controllerPassword.text.length >= 8) {
                      return null;
                    } else {
                      return "Passwort benötigt mindestens 8 Zeichen";
                    }
                  })),
              Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextInput("Passwort wiederholen", Icons.lock,
                      _controllerRepeatPassword, isPassword: true, customValidator: (value) {
                    if (_controllerRepeatPassword.text.length >= 8) {
                      return null;
                    }
                    if (_controllerPassword.text !=
                        _controllerRepeatPassword.text) {
                      return "Passwort muss gleich sein";
                    } else {
                      return "Passwort benötigt mindestens 8 Zeichen";
                    }
                  })),
              Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: MaterialButton(
                    child: Text('Registrieren'),
                    color: Colors.blueAccent,
                    onPressed: () {
                      password = _controllerPassword.text;
                      passwordRepeat = _controllerRepeatPassword.text;

                      if (_formKey.currentState.validate()) print("valide");
                      if (password == passwordRepeat && password.length >= 8) {
                        user.password = password;
                        if (_controllerEmail.text.isNotEmpty &&
                            _controllerFirstName.text.isNotEmpty &&
                            _controllerEmail.text.isNotEmpty &&
                            mailIsValid) {
                          user.mail = _controllerEmail.text;
                          user.username = _controllerNickname.text;
                          user.firstName = _controllerFirstName.text;

                          this
                              .userService
                              .addUser(user)
                              .then((val) => print(val.toString()));

                          Navigator.pop(context);
                        }
                      } else {
                        print("Passwort bitte erneut eingeben");
                      }
                    },
                  )),
            ]),
          ),
        ),
      ),
    );
  }
}
