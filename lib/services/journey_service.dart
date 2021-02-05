import 'dart:async';
import 'package:traveltogether_frontend/mapping-functions/map_journey_to_view_model.dart';
import 'package:traveltogether_frontend/services/service_base.dart';
import 'package:traveltogether_frontend/view-models/journey_view_model.dart';

class JourneyService extends ServiceBase {
  final String url = "journeys";

  Future<JourneyViewModel> get(int id) async {
    var journey = await getHttpBody('$url/${id.toString()}')
        .then((json) => mapJourneyToViewModel(json));

    return journey;
  }

  Future<List<JourneyViewModel>> getAll() async {
    var journeys = await getHttpBody('$url')
        .then((json) {
          List<JourneyViewModel> journeys = [];
          List<dynamic> jsonJourneys = json["journeys"];
          jsonJourneys.forEach((journey) => journeys.add(mapJourneyToViewModel(journey)));
          return journeys;
    });

    return journeys;
  }
}
