import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traveltogether_frontend/pages/edit_profile_page.dart';
import 'package:traveltogether_frontend/pages/login_page.dart';
import 'package:traveltogether_frontend/pages/pending_page.dart';
import 'package:traveltogether_frontend/pages/requests_and_offers_page.dart';
import 'package:traveltogether_frontend/pages/settings_page.dart';
import 'package:traveltogether_frontend/services/navigator_service.dart';
import 'package:traveltogether_frontend/services/theme_service.dart';
import 'package:traveltogether_frontend/services/user_service.dart';
import 'package:traveltogether_frontend/view-models/user_read_view_model.dart';
import 'package:traveltogether_frontend/websockets/chat_communication.dart';
import 'package:traveltogether_frontend/widgets/type_enum.dart';

ChatCommunication chat;

void run() {
  runApp(MaterialApp(home: LoginPage()));
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  UserService userService = new UserService();
  bool isHighContrast = false;

  @override
  void initState() {
    super.initState();
    checkIfUserIsLoggedIn();
    readHighContrast();
  }

  checkIfUserIsLoggedIn() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("authKey") == null) {
      navigatorKey.currentState.pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      chat = ChatCommunication();
    }
  }

  readHighContrast() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    isHighContrast = sharedPreferences.getBool("HighContrastMode");
    if (isHighContrast == null) {
      isHighContrast = false;
    }
    if (isHighContrast) {
      ThemeService.data = FlexColorScheme.dark(
        colors: FlexColor.schemes[FlexScheme.mandyRed].dark,
      ).toTheme;
    } else {
      ThemeService.data = FlexColorScheme.light(
        colors: FlexColor.schemes[FlexScheme.brandBlue].light,
      ).toTheme;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      darkTheme: ThemeService.data ??
          FlexColorScheme.light(
            colors: FlexColor.schemes[FlexScheme.brandBlue].light,
          ).toTheme,
      home: Scaffold(
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
                                        builder: (context) =>
                                            EditProfilePage()));
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
                                    builder: (context) => RequestsAndOffersPage(
                                        "offers", snapshot.data)));
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
                                    builder: (context) => RequestsAndOffersPage(
                                        "requests", snapshot.data)));
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
                                builder: (context) =>
                                    PendingPage(snapshot.data.id)));
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
        body: Align(
          child: Column(
              children: [
                Text.rich(TextSpan(
                    text: "Herzlich Willkommen!",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
                Text.rich(TextSpan(
                    text: "Klicke auf das Menü links oben",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
                Text.rich(TextSpan(
                    text: "um etwas zu tun.",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center),
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
