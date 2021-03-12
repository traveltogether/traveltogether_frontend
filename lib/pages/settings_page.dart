import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  bool isHighContrast = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readHighContrast();
  }

  @override
  Widget build(BuildContext context) {
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
                });
              },
              activeTrackColor: Colors.lightBlueAccent,
              activeColor: Colors.lightBlue,
              secondary: const Icon(Icons.lightbulb_outline),
            ),
          ],
        ));
  }

  writeHighContrast(bool isHighContrast) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool("HighContrastMode", isHighContrast);
  }

  readHighContrast() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    isHighContrast = sharedPreferences.getBool("HighContrastMode");
    setState(() {});
  }
}
