import 'package:flutter/material.dart';

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

      @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registrierung"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <
              Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Email',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.blue,
                  )),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
                    if(emailValid==true){
                      email = value;
                      print(emailValid);
                    }
                    else{
                      email = null;
                      print("ungültig");
                    }
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Nutzername',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.blue,
                  )),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    nickname = value;
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_outline),
                  hintText: 'Vorname',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.blue,
                  )),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    realname = value;
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
                    print(password);
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
                  hintText: 'Passwort wiederholen',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.blue,
                  )),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    passwordRepeat = value;
                  });
                },
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: MaterialButton(
                  child: Text('Registrieren'),
                  color: Colors.blue,
                  onPressed: () {
                    if(password == passwordRepeat){

                    }
                    else{
                      print("Passwort bitte erneut eingeben");
                    }
                  },
                )),
          ]),
        ),
      ),
    );
  }
}
