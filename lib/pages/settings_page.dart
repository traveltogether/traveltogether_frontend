import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';



class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  bool isHighContrast = false; //JSON Aufruf
  bool isSwitched = false;

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
      value: isSwitched,
      onChanged: (bool value) {
        setState(() {
          isSwitched = value;
          changeHighcontrast();
          isHighContrast = value;
          changeHighcontrast();
          //widget.settings.darkMode = isDarkMode;
          //saveSettings(widget.settings);
        });
      },
      activeTrackColor: Colors.lightBlueAccent,
      activeColor: Colors.lightBlue,
      secondary: const Icon(Icons.lightbulb_outline),
    ),
    ],
    )
    );
  }
}

void changeHighcontrast(){
  darkTheme: FlexColorScheme.dark(
    colors: FlexColor.schemes[FlexScheme.mandyRed].dark,
  ).toTheme;


  return;
}

