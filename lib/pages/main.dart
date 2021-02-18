import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/journey_service.dart';
import 'package:traveltogether_frontend/services/user_service.dart';
import 'package:traveltogether_frontend/view-models/user_write_view_model.dart';
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
    var user = new UserWriteViewModel();
    user.username = "Kiyaran";
    user.firstName = "Alp";
    user.disabilities = "Brillenträger";
    user.password = "Nika";
    user.mail = "NikaIstLehrerin@Stevenger.Liadan";
    this.userService.add(user).then((val)=>print(val.toString()));
    this.userService.getUser(4).then((val) => setState(() {
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
