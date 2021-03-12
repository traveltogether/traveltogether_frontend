import 'package:traveltogether_frontend/view-models/journey_read_view_model.dart';

class JourneyLists {
  final List<JourneyReadViewModel> journeys;
  final List<JourneyReadViewModel> othersJourneys;
  final List<JourneyReadViewModel> cancelledJourneys;
  final List<JourneyReadViewModel> cancelledOthersJourneys;

  JourneyLists(this.journeys, this.othersJourneys, this.cancelledJourneys,
      this.cancelledOthersJourneys);
}
