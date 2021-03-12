import 'package:flutter/material.dart';
import '../widgets/text_input.dart';
import 'package:traveltogether_frontend/services/user_service.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  String name;
  String password;

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
                        TextInput("Passwort", Icons.lock, _controllerPassword, isObscure: true)),
                SizedBox(height: 170),
                Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: MaterialButton(
                      child: Text('Login'),
                      color: Colors.blue,
                      onPressed: () {
                        userService.login(
                            _controllerName.text, _controllerPassword.text).then((value) => Navigator.pop(context),
                        );

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
}
