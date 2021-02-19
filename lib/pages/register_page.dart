import 'package:flutter/material.dart';
import '../widgets/text_input.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  String email;
  String nickname;
  String realname;
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
                      email = value;
                      return null;
                    } else {
                      email = null;
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
                  child:
                      TextInput("Passwort", Icons.lock, _controllerPassword)),
              Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextInput("Passwort wiederholen", Icons.lock,
                      _controllerRepeatPassword)),
              Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: MaterialButton(
                    child: Text('Registrieren'),
                    color: Colors.blue,
                    onPressed: () {
                      email = _controllerEmail.text;
                      nickname = _controllerNickname.text;
                      realname = _controllerFirstName.text;
                      password = _controllerPassword.text;
                      passwordRepeat = _controllerRepeatPassword.text;

                      if (_formKey.currentState.validate()) print("valide");

                      if (password == passwordRepeat) {
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
