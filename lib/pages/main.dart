import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/journey_service.dart';
import 'package:traveltogether_frontend/services/user_service.dart';
import '../widgets/request_and_offer_card.dart';
import 'login_page.dart';
import 'register_page.dart';
import '../widgets/pop_up.dart';


String username = "";
String firstName = "";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
  JourneyService journeyService = new JourneyService();
  UserService userService = new UserService();
  String textfieldContent = "";

  _MyHomePageState() {
    this.journeyService.joinJourney(4).then((val) => setState(() {
          textfieldContent = val.toString();
        }));

    this.userService.getUser(4).then((val) => setState(() {
          print("meldung meldung!!!!!" + val.toString());
          textfieldContent = val.firstName.toString();
          userService.changePassword("Nika", "Alp");
    }));


    userService.getCurrentUser().then((currentUser) => setState(() {
      setState(() {
        username = currentUser.username;
        firstName = currentUser.firstName;
      });
    }),
    );

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(username),
              accountEmail: Text(firstName),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://blog.wwf.de/wp-content/uploads/2019/10/pinguine.jpg"),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            ListTile(
              leading: Icon(Icons.mail),
              title: Text("Register"),
              onTap: () {
                setState(
                  () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                  },
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.mail),
              title: Text("Login"),
              onTap: () {
                setState(
                  () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.mail),
              title: Text("Pop Up test"),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return PopUp("Journey", "Hier ist ein Fehler passiert weil Fehler und sowas");
                  },
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.mail),
              title: Text("Nummer 4"),
              onTap: () {},
            ),
            Divider(),
            Expanded(
                child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: ListTile(
                leading: Icon(Icons.settings),
                title: Text("Einstellungen"),
                onTap: () {},
              ),
            ))
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
