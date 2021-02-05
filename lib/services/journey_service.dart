import 'dart:async';
import 'package:traveltogether_frontend/services/service_base.dart';

class JourneyService extends ServiceBase {
  final String url = "journeys/";

  Future<String> get(int id) async {
    var journey = await getHttpBody('$url${id.toString()}').then((value) => value.toString());
    return journey;
  }
}
