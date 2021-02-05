import 'package:flutter/material.dart';
import '../widgets/text_input.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  List<String> data = ['peter@gmail.com', 'P3ter', 'abcd1234'];
  String name;
  String password;

  bool check;

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 170),
                Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child: TextInput(
                        "Username oder Email", Icons.person, _controllerName)),
                Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child:
                        TextInput("Passwort", Icons.lock, _controllerPassword)),
                SizedBox(height: 170),
                Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: MaterialButton(
                      child: Text('Login'),
                      color: Colors.blue,
                      onPressed: () {
                        print(_controllerName.text);
                        name = _controllerName.text;

                        password = _controllerPassword.text;
                        if (_validation(name, password)) {
                          print("Erfolgreicher Login");
                        } else {
                          print(
                              "Nutzerdaten nicht vorhanden, bitte Probieren Sie es erneut");
                        }

                        if (_formKey.currentState.validate()) print("valide");
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _validation(String name, String password) {
    if (data[0] == name || data[1] == name) {
      if (password == data[2]) {
        return true;
      }
    } else {
      return false;
    }
  }
}
