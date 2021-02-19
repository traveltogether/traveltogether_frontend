import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/journey_service.dart';
import 'package:traveltogether_frontend/services/user_service.dart';
import '../widgets/request_and_offer_card.dart';
import 'login_page.dart';
import 'register_page.dart';


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
  UserService userService = new UserService();
  JourneyService journeyService = new JourneyService();
  String textfieldContent = "";

  _MyHomePageState() {
    this.journeyService.joinJourney(4).then((val) => setState(() {
          textfieldContent = val.toString();
        }));

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

      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text("hiersteht@eine.mail"),
              accountName: Text("EinName"),
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
                        context, MaterialPageRoute(builder: (context) => RegisterPage()));
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
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.mail),
              title: Text("Nummer 3"),
              onTap: () {},
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
