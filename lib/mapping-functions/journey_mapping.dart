import 'package:flutter/cupertino.dart';

import '../view-models/journey_write_view_model.dart';
import '../view-models/journey_read_view_model.dart';

JourneyReadViewModel mapJourneyToReadViewModel(Map<String, dynamic> json) {
  var journey = new JourneyReadViewModel();

  journey.id = json["id"];
  journey.userId = json["user_id"];
  journey.isOffer = json["offer"];
  journey.isRequest = json["request"];
  journey.startAddress = json["start_address"];
  journey.endAddress = json["end_address"];
  journey.approximateStartAddress = json["approximate_start_address"];
  journey.approximateEndAddress = json["approximate_end_address"];
  journey.departureTime = json["time_is_departure"] ? json["time"] : null;
  journey.arrivalTime = json["time_is_arrival"] ? json["time"] : null;
  journey.isOpenForRequests = json["open_for_requests"];
  if (json.containsKey("note")) journey.note = json["note"];

  if (json.containsKey("pending_user_ids") && !json["pending_user_ids"].isEmpty)
    journey.pendingUserIds = new List<int>.from(json["pending_user_ids"]);
  if (json.containsKey("accepted_user_ids") &&
      !json["accepted_user_ids"].isEmpty)
    journey.acceptedUserIds = new List<int>.from(json["accepted_user_ids"]);
  if (json.containsKey("declined_user_ids") &&
      !json["declined_user_ids"].isEmpty)
    journey.declinedUserIds = new List<int>.from(json["declined_user_ids"]);

  journey.cancelledByHost = json["cancelled_by_host"];
  if (journey.cancelledByHost) {
    journey.cancelledByHostReason = json["cancelled_by_host_reason"];
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
  json["time_is_arrival"] = journey.arrivalTime == null ? false : true;
  json["time_is_departure"] = journey.departureTime == null ? false : true;
  if (journey.note != null) json["note"] = journey.note;
  return json;
}
