import '../view-models/journey_view_model.dart';

JourneyViewModel mapJourneyToViewModel(Map<String, dynamic> json){
  var journey = new JourneyViewModel();

  journey.id = json["id"];
  journey.userId = json["user_id"];
  journey.startAddress = json["start_address"];
  journey.endAddress = json["end_address"];
  journey.approximateStartAddress = json["approximate_start_address"];
  journey.approximateEndAddress = json["approximate_end_address"];
  journey.departureTime = json["time_is_departure"]? json["time"] : null;
  journey.arrivalTime = json["time_is_arrival"]? json["time"] : null;

  return journey;
}