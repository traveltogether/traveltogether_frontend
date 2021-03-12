import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traveltogether_frontend/pages/edit_profile_page.dart';
import 'package:traveltogether_frontend/pages/pending_page.dart';
import 'package:traveltogether_frontend/pages/login_page.dart';
import 'package:traveltogether_frontend/pages/requests_and_offers_page.dart';
import 'package:traveltogether_frontend/pages/settings_page.dart';
import 'package:traveltogether_frontend/services/user_service.dart';
import 'package:traveltogether_frontend/websockets/chat_communication.dart';
import 'package:traveltogether_frontend/view-models/user_read_view_model.dart';
import 'package:traveltogether_frontend/widgets/type_enum.dart';

import 'package:flex_color_scheme/flex_color_scheme.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  Color color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navigatorKey,

      theme: FlexColorScheme.light(
        colors: FlexColor.schemes[FlexScheme.brandBlue].light,
      ).toTheme,

      darkTheme: FlexColorScheme.dark(
        colors: FlexColor.schemes[FlexScheme.mandyRed].dark,
      ).toTheme,

      themeMode: ThemeMode.system, //main zeile zum ändern

      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),

      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  UserService userService = new UserService();

  @override
  void initState() {
    super.initState();
    checkIfUserIsLoggedIn();
  }

  checkIfUserIsLoggedIn() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("authKey") == null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),

      drawer: Drawer(
        child: FutureBuilder<UserReadViewModel>(
          future: userService.getCurrentUser(),
          builder: (BuildContext context,
              AsyncSnapshot<UserReadViewModel> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              print(snapshot.data.id);
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
                                      RequestsAndOffersPage("offers", snapshot.data)));
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
                                      RequestsAndOffersPage("requests", snapshot.data)));
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
                              builder: (context) => PendingPage(snapshot.data.id)));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.mail),
                    title: Text("Chat"),
                    onTap: () {
                      chat.send(
                          Type.ChatRoomsPacket, snapshot.data.id.toString());
                    },
                  ),
                  Divider(),
                  Expanded(
                      child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: ListTile(
                      leading: Icon(Icons.settings),
                      title: Text("Einstellungen"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsPage()));
                      },
                    ),
                  ))
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
