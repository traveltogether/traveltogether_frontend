import 'package:flutter/material.dart';
import 'package:osm_nominatim/osm_nominatim.dart';
import 'package:traveltogether_frontend/view-models/journey_write_view_model.dart';
import 'package:traveltogether_frontend/widgets/nominatim_search_address.dart';

class JourneyCreationPopUp extends StatelessWidget {
  final String startAdress;
  final String endAddress;
  final JourneyWriteViewModel journey;

  JourneyCreationPopUp(this.startAdress, this.endAddress, this.journey);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: FutureBuilder<List<Place>>(
            future: Future.wait(
                [searchAddress(startAdress), searchAddress(endAddress)]),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }else{
                if (snapshot.data[0] != null && snapshot.data[1] != null){
                  Navigator.pop(context, true);
                  return SizedBox.shrink();
                }else{
                  return Center(
                    child: Text("");
                  );
                }
              }
            }));
  }
}
