import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/view-models/journey_write_view_model.dart';
import 'package:traveltogether_frontend/widgets/journey_creation_popup.dart';
import '../widgets/text_input.dart';
import 'package:traveltogether_frontend/services/journey_service.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class AddJourneyPage extends StatefulWidget {
  AddJourneyPage({Key key}) : super(key: key);

  @override
  AddJourneyPageState createState() => AddJourneyPageState();
}

class AddJourneyPageState extends State<AddJourneyPage> {
  var journey = new JourneyWriteViewModel();
  JourneyService journeyService = new JourneyService();

  bool request;
  bool offer;
  String startLatLong;
  String endLatLong;
  DateTime journeyDay;
  DateTime departureTime;
  DateTime arrivalTime;
  String note;

  final _formKey = GlobalKey<FormState>();

  int _radioValue = 0;
  TextEditingController _controllerStartLatLong;
  TextEditingController _controllerEndLatLong;
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

  _createJourney(int departure, int arrival) {
    journey.request = request;
    journey.offer = offer;
    journey.departureTime = departure;
    journey.arrivalTime = arrival;
    journey.note = _controllerNote.text;
    return journey;
    //journeyService.add(journey);
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
                    child: TextInput("Start-Adresse", Icons.location_on,
                        _controllerStartLatLong)),
                Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child: TextInput("Ziel-Adresse", Icons.location_on,
                        _controllerEndLatLong)),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: Column(children: <Widget>[
                    Text('Tag auswählen: '),
                    DateTimeField(
                      validator: (value) {
                        if (value == null) {
                          return "Bitte Eingebefeld ausfüllen";
                        }
                        return null;
                      },
                      format: DateFormat("yyyy-MM-dd"),
                      onShowPicker: (context, currentValue) async {
                        final date = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now().add(Duration(days: 1)),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                        journeyDay = date;
                        return journeyDay;
                      },
                    ),
                    Text(''),
                    Text('Abfahrtzeit:'),
                    DateTimeField(
                      validator: (value) {
                        if (value == null) {
                          return "Bitte Eingebefeld ausfüllen";
                        }
                        return null;
                      },
                      format: DateFormat("HH:mm"),
                      onShowPicker: (context, currentValue) async {
                        if (journeyDay != null) {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                                currentValue ?? DateTime.now()),
                          );
                          departureTime =
                              DateTimeField.combine(journeyDay, time);
                          return departureTime;
                        } else {
                          return currentValue;
                        }
                      },
                    ),
                    Text(''),
                    Text('Ankunftzeit:'),
                    DateTimeField(
                      validator: (value) {
                        if (value == null) {
                          return "Bitte Eingebefeld ausfüllen";
                        }
                        return null;
                      },
                      format: DateFormat("HH:mm"),
                      onShowPicker: (context, currentValue) async {
                        if (journeyDay != null) {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                                currentValue ?? DateTime.now()),
                          );
                          arrivalTime = DateTimeField.combine(journeyDay, time);
                          return arrivalTime;
                        } else {
                          return currentValue;
                        }
                      },
                    ),
                  ]),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextFormField(
                    controller: _controllerNote,
                    minLines: 2,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Notizen...',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: MaterialButton(
                        child: Text('Fahrt Erstellen'),
                        color: Colors.blueAccent,
                        onPressed: () {
                          _createJourney(
                              departureTime.toUtc().millisecondsSinceEpoch,
                              arrivalTime.toUtc().millisecondsSinceEpoch);
                          if (_formKey.currentState.validate()) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return JourneyCreationPopUp(
                                      _controllerStartLatLong.text,
                                      _controllerEndLatLong.text,
                                      journey);
                                });
                          }
                        }))
              ]),
            ),
          ),
        ));
  }
}
