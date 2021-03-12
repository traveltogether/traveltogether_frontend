import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/pages/edit_profile_page.dart';
import 'package:traveltogether_frontend/pages/pending_page.dart';
import 'package:traveltogether_frontend/services/user_service.dart';
import 'add_journey_page.dart';
import 'file:///C:/Users/AnandarL/Documents/semester%204/SWE%20II/traveltogether_frontend/lib/websockets/chat_communication.dart';
import 'package:traveltogether_frontend/view-models/user_read_view_model.dart';
import 'package:traveltogether_frontend/widgets/type_enum.dart';
import 'requests_and_offers_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String textfieldContent = "";
  UserService userService = new UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      drawer: Drawer(
        child: FutureBuilder<UserReadViewModel>(
          future: userService.getCurrentUser(),
          builder: (BuildContext context,
              AsyncSnapshot<UserReadViewModel> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Column(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text(snapshot.data.username),
                    accountEmail: Text(snapshot.data.firstName),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://blog.wwf.de/wp-content/uploads/2019/10/pinguine.jpg"),
                      child: Padding(
                        padding: EdgeInsets.only(top: 35, left: 40),
                        child: CircleAvatar(
                          backgroundColor: Colors.black54,
                          child: IconButton(
                            iconSize: 20,
                            icon: Icon(Icons.edit, color: Colors.white),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfilePage()));
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  ListTile(
                    leading: Icon(Icons.mail),
                    title: Text("Angebote"),
                    onTap: () {
                      setState(
                        () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RequestsAndOffersPage("offers")));
                        },
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.mail),
                    title: Text("Anfragen"),
                    onTap: () {
                      setState(
                        () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RequestsAndOffersPage("requests")));
                        },
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.mail),
                    title: Text("Meine Fahrten"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PendingPage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.mail),
                    title: Text("Fahrt erstellen"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddJourneyPage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.mail),
                    title: Text("Chat"),
                    onTap: () {
                      chat.send(Type.ChatRoomsPacket, snapshot.data.id.toString());
                    },
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
              );
            }
          },
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
