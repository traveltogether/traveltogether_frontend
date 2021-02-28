import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/user_service.dart';
import 'requests_and_offers_page.dart';

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
  String textfieldContent = "";

  _MyHomePageState() {
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
              title: Text("Angebote"),
              onTap: () {
                setState(
                      () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RequestsAndOffersPage("offers")));
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RequestsAndOffersPage("requests")));
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
