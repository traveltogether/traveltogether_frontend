import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:traveltogether_frontend/mapping-functions/map_journey_to_view_model.dart';
import 'package:traveltogether_frontend/services/service_base.dart';
import 'package:traveltogether_frontend/view-models/journey_view_model.dart';

class JourneyService extends ServiceBase {
  final String url = "journeys";

  Map<String, String> assembleQueryParameters([bool openForRequests, bool request, bool offer]) {
    var queryParameters = new Map<String, String>();
    if (openForRequests != null) queryParameters["openForRequests"] = openForRequests.toString();
    if (request != null) queryParameters["request"] = request.toString();
    if (offer != null) queryParameters["offer"] = offer.toString();
    return queryParameters;
  }

  Future<JourneyViewModel> get(int id) async {
    var journey = await getHttpBody('$url/${id.toString()}')
        .then((json) => mapJourneyToViewModel(json));

    return journey;
  }

  Future<List<JourneyViewModel>> getAll({bool openForRequests, bool request, bool offer}) async {
    var queryParameters = assembleQueryParameters(openForRequests, request, offer);
    var journeys = await getHttpBody('$url', queryParameters)
        .then((json) {
          List<JourneyViewModel> journeys = [];
          List<dynamic> jsonJourneys = json["journeys"];
          jsonJourneys.forEach((journey) => journeys.add(mapJourneyToViewModel(journey)));
          return journeys;
    });

    return journeys;
  }
}
