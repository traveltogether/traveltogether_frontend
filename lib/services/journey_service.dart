import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:traveltogether_frontend/mapping-functions/journey_mapping.dart';
import 'package:traveltogether_frontend/services/service_base.dart';
import 'package:traveltogether_frontend/view-models/journey_read_view_model.dart';
import 'package:traveltogether_frontend/view-models/journey_write_view_model.dart';

class JourneyService extends ServiceBase {
  final String url = "journeys";

  Map<String, String> assembleQueryParameters(
      [bool openForRequests, bool request, bool offer]) {
    var queryParameters = new Map<String, String>();
    if (openForRequests != null)
      queryParameters["openForRequests"] = openForRequests.toString();
    if (request != null) queryParameters["request"] = request.toString();
    if (offer != null) queryParameters["offer"] = offer.toString();
    return queryParameters;
  }

  Future<JourneyReadViewModel> getJourney(int id) async {
    debugPrint("getJourney");
    var journey = await get('$url/${id.toString()}')
        .then((json) => mapJourneyToReadViewModel(json));

    return journey;
  }

  Future<List<JourneyReadViewModel>> getAll(
      {bool openForRequests, bool request, bool offer}) async {
    var queryParameters =
        assembleQueryParameters(openForRequests, request, offer);

    var journeys = await get('$url', queryParameters).then((json) {
      List<JourneyReadViewModel> journeys = [];
      List<dynamic> jsonJourneys = json["journeys"];
      jsonJourneys.forEach(
          (journey) => journeys.add(mapJourneyToReadViewModel(journey)));

      return journeys;
    });

    return journeys;
  }

  Future<Map<String, dynamic>> add(JourneyWriteViewModel journey) async {
    var json = mapJourneyToJson(journey);
    return await post('$url', json);
  }

  Future<Map<String, dynamic>> changeJourneyState(int id, bool newState) async {
    return put('$url/$id/open', {"value": newState});
  }

  Future<Map<String, dynamic>> deleteJourney(int id) async {
    return delete('$url/$id');
  }

  Future<Map<String, dynamic>> joinJourney(int id) {
    return post('$url/$id/join');
  }
}
