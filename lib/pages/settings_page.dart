import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traveltogether_frontend/widgets/pop_up.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    readHighContrast();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: readHighContrast(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();

          bool isHighContrast = snapshot.data;
          return Scaffold(
              appBar: AppBar(
                title: Text("Einstellungen"),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SwitchListTile(
                    title: const Text('High Contrast'),
                    value: isHighContrast,
                    onChanged: (bool value) {
                      setState(() {
                        isHighContrast = value;
                        writeHighContrast(value);
                        showDialog(
                            context: context,
                            builder: (context) {
                              return PopUp("Hinweis",
                                  "Bitte starten Sie für diese Änderung die Applikation neu");
                            });
                      });
                    },
                    activeTrackColor: Colors.lightBlueAccent,
                    activeColor: Colors.lightBlue,
                    secondary: const Icon(Icons.lightbulb_outline),
                  ),
                ],
              ));
        });
  }

  writeHighContrast(bool isHighContrast) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool("HighContrastMode", isHighContrast);
  }

  Future<bool> readHighContrast() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool("HighContrastMode") ?? false;
  }
}
