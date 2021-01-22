import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Email Oder Nutzername',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.blue,
                    )),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'Passwort',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.blue,
                    )),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
              ),
              Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: MaterialButton(
                    child: Text('Login'),
                    color: Colors.blue,
                    onPressed: () {
                      if (_validation(name, password) == true ||
                          _validation(name, password) == true) {
                        print("Erfolgreicher Login");
                      } else {
                        print(
                            "Nutzerdaten nicht vorhanden, bitte Probieren sie es erneut");
                      }
                    },
                  )),
            ],
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
