import '../view-models/journey_write_view_model.dart';
import '../view-models/journey_read_view_model.dart';

JourneyReadViewModel mapJourneyToReadViewModel(Map<String, dynamic> json) {
  var journey = new JourneyReadViewModel();

  journey.id = json["id"];
  journey.userId = json["user_id"];
  journey.startAddress = json["start_address"];
  journey.endAddress = json["end_address"];
  journey.approximateStartAddress = json["approximate_start_address"];
  journey.approximateEndAddress = json["approximate_end_address"];
  journey.departureTime = json["time_is_departure"] ? json["time"] : null;
  journey.arrivalTime = json["time_is_arrival"] ? json["time"] : null;
  if (json.containsKey("note")) {
    journey.note = json["note"];
  }

  return journey;
}

Map<String, dynamic> mapJourneyToJson(JourneyWriteViewModel journey) {
  var json = new Map<String, dynamic>();

  json["request"] = journey.request;
  json["offer"] = journey.offer;
  json["start_lat_long"] = journey.startLatLong;
  json["end_lat_long"] = journey.endLatLong;
  json["time"] = journey.departureTime == null
      ? journey.arrivalTime
      : journey.departureTime;
  json["time_is_arrival"] = journey.arrivalTime == null ? false : true ;
  json["time_is_departure"] = journey.departureTime == null ? false : true ;
  if (journey.note != null) {
    json["note"] = journey.note;
  }

  return json;
}
