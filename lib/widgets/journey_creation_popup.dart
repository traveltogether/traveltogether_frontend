import 'package:flutter/material.dart';
import 'package:osm_nominatim/osm_nominatim.dart';
import 'package:traveltogether_frontend/view-models/journey_write_view_model.dart';
import 'package:traveltogether_frontend/widgets/nominatim_search_address.dart';
import 'package:traveltogether_frontend/services/journey_service.dart';

class JourneyCreationPopUp extends StatefulWidget {
  final String startAddress;
  final String endAddress;
  final JourneyWriteViewModel journey;

  JourneyCreationPopUp(this.startAddress, this.endAddress, this.journey);

  @override
  _JourneyCreationPopUpState createState() => _JourneyCreationPopUpState();
}

class _JourneyCreationPopUpState extends State<JourneyCreationPopUp> {
  final JourneyService journeyService = new JourneyService();

  bool areButtonsDisabled = true;

  bool isStartAddressValid;

  bool isEndAddressValid;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Fahrt erstellen",
      ),
      content: FutureBuilder<List<Place>>(
          future: Future.wait(
              [searchAddress(widget.startAddress), searchAddress(widget.endAddress)]),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 95),
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  width: 40,
                  height: 40,
                ),
              );
            } else {
              if (snapshot.data[0] != null && snapshot.data[1] != null) {
                widget.journey.startLatLong =
                    [snapshot.data[0].lat, snapshot.data[0].lon].join(";");
                widget.journey.endLatLong =
                    [snapshot.data[1].lat, snapshot.data[1].lon].join(";");
                isStartAddressValid = true;
                isEndAddressValid = true;
                print(widget.journey.startLatLong);
                print(widget.journey.endLatLong);
                print(widget.journey.request);
                print(widget.journey.offer);
                print(widget.journey.departureTime);
                print(widget.journey.arrivalTime);
                print(widget.journey.note);
                return FutureBuilder<Map<String, dynamic>>(
                    future: journeyService.add(widget.journey),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 95),
                          child: SizedBox(
                            child: CircularProgressIndicator(),
                            width: 40,
                            height: 40,
                          ),
                        );
                      } else {
                        areButtonsDisabled = false;
                        if (snapshot.data["error"] == null) {
                          return Text(
                                  "Deine Fahrt wurde erfolgreich erstellt!");
                        } else {
                          return Text(snapshot.data["error"] +
                                  "\n\nBitte kontaktiere den Support.");
                        }
                      }
                    });
              } else {
                areButtonsDisabled = false;
                if (snapshot.data[0] != null) isStartAddressValid = true;
                if (snapshot.data[1] != null) isEndAddressValid = true;
                return Text(
                        "Die angegebenen Adressen konnten nicht gefunden werden.");
              }
            }
          }),
      actions: [
        TextButton(
            onPressed: () {
              if (!areButtonsDisabled) {
                Navigator.pop(
                    context, [isStartAddressValid, isEndAddressValid]);
              }
            },
            child: Text("ok"))
      ],
    );
  }
}
