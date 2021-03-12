import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/view-models/journey_write_view_model.dart';
import 'package:traveltogether_frontend/widgets/journey_creation_popup.dart';
import '../widgets/text_input.dart';
import 'package:traveltogether_frontend/services/journey_service.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'main.dart';

class AddJourneyPage extends StatefulWidget {
  AddJourneyPage({Key key}) : super(key: key);

  @override
  AddJourneyPageState createState() => AddJourneyPageState();
}

class AddJourneyPageState extends State<AddJourneyPage> {
  var journey = new JourneyWriteViewModel();
  JourneyService journeyService = new JourneyService();

  bool request = false;
  bool offer = true;
  String startLatLong;
  String endLatLong;
  DateTime journeyDay;
  DateTime time;
  bool timeIsDeparture = true;
  String note;

  final _formKey = GlobalKey<FormState>();

  int _radioValue = 0;
  int _timeRadioValue = 0;
  TextEditingController _controllerStartLatLong = new TextEditingController();
  TextEditingController _controllerEndLatLong = new TextEditingController();
  int _departureTime;
  int _arrivalTime;
  TextEditingController _controllerNote;

  @override
  void initState() {
    super.initState();
    _controllerNote = new TextEditingController();
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 0:
          offer = true;
          request = false;
          break;
        case 1:
          offer = false;
          request = true;
          break;
      }
    });
  }

  void _handleTimeRadioValueChange(int value) {
    setState(() {
      _timeRadioValue = value;
      switch (_timeRadioValue) {
        case 0:
          timeIsDeparture = false;
          break;
        case 1:
          timeIsDeparture = true;
          break;
      }
      print(timeIsDeparture);
    });
  }

  _createJourney(int time) {
    journey.request = request;
    journey.offer = offer;
    journey.departureTime = timeIsDeparture ? time : null;
    journey.arrivalTime = timeIsDeparture ? null : time;
    journey.note = _controllerNote.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fahrt Erstellen"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: <
                      Widget>[
                Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child: Row(
                      children: <Widget>[
                        Radio(
                          value: 0,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        Text(
                          'Angebot',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Radio(
                          value: 1,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        Text(
                          'Anfrage',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    )),

                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: Column(children: <Widget>[
                    Padding(
                        padding:
                        EdgeInsets.only(bottom: 15),
                        child: TextInput("Startadresse", Icons.location_on,
                            _controllerStartLatLong)),
                    Padding(
                        padding:
                        EdgeInsets.only(bottom: 25),
                        child: TextInput("Zieladresse", Icons.location_on,
                            _controllerEndLatLong)),
                    DateTimeField(
                      format: DateFormat("dd.MM.yyyy"),
                      decoration: InputDecoration(
                        hintText: "Tag auswählen",
                        border: const OutlineInputBorder(),
                      ),
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                      },
                      onChanged: (value) {
                        journeyDay = value;
                      },
                      validator: (value) {
                        if (value == null) {
                          return "Bitte Eingebefeld ausfüllen";
                        }
                        return null;
                      },
                    ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 0,
                    groupValue: _timeRadioValue,
                    onChanged: _handleTimeRadioValueChange,
                  ),
                  Text(
                    'Startzeit',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Radio(
                    value: 1,
                    groupValue: _timeRadioValue,
                    onChanged: _handleTimeRadioValueChange,
                  ),
                  Text(
                    'Endzeit',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
                    Padding(
                      padding: EdgeInsets.only(top:15, bottom: 15),
                      child: DateTimeField(
                        decoration: InputDecoration(
                          hintText: "Zeit",
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return "Bitte Eingebefeld ausfüllen";
                          }
                          return null;
                        },
                        format: DateFormat("HH:mm"),
                        onShowPicker: (context, currentValue) async {
                          print(journeyDay.toString());
                          if (journeyDay != null) {
                            final pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(
                                  currentValue ?? DateTime.now()),
                            );
                            time = DateTimeField.combine(journeyDay, pickedTime);
                            return time;
                          } else {
                            return currentValue;
                          }
                        },
                      ),
                    ),
                  ]),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(right: 15, left: 15, bottom: 17),
                  child: TextFormField(
                    controller: _controllerNote,
                    minLines: 1,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Notizen...',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      child: Text("Abbrechen"),
                      onPressed: () { Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyHomePage()));
                      },
                    ),
                        ElevatedButton(
                            child: Text('Fahrt Erstellen'),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _createJourney(
                                    time.toUtc().millisecondsSinceEpoch);
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return JourneyCreationPopUp(
                                          _controllerStartLatLong.text,
                                          _controllerEndLatLong.text,
                                          journey);
                                    }).then((response) {
                                  print(response);
                                });
                              }
                            })
                  ]
                )
              ]),
            ),
          ),
        ));
  }
}
