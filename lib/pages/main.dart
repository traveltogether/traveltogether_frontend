import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/user_service.dart';
import '../widgets/request_and_offer_card.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  UserService userService = new UserService();
  String textfieldContent = "";

  _MyHomePageState() {


    this.userService.changeDisability(3,"testDis").then((value) => print("change disability: " + value.toString()));
    userService.login("test", "test").then((value) => print("login: "+ value.toString()));

    userService.changeUsername(3, "Test").then((value) => print(value));
    userService.changeMail("test@test").then((value) => print("mail change: "+ value.toString()));
    userService.changePassword("test", "test").then((value) => print("change password: "+ value.toString()));

    this.userService.getUser(3).then((val) => setState(() {
      print("meldung meldung!!!!!" + val.toString());
      textfieldContent = val.disabilities.toString();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RequestAndOfferCard(),
            Text(textfieldContent),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
