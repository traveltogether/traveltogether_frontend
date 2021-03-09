import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/view-models/journey_read_view_model.dart';
import 'package:traveltogether_frontend/view-models/user_read_view_model.dart';
import 'package:traveltogether_frontend/widgets/accepted_other_journey_button_row.dart';
import 'package:traveltogether_frontend/widgets/accepted_user_button_row.dart';
import 'package:traveltogether_frontend/widgets/declined_other_journey_button_row.dart';
import 'package:traveltogether_frontend/widgets/pending_other_journey_button_row.dart';
import 'package:traveltogether_frontend/widgets/pending_user_button_row.dart';
import 'package:traveltogether_frontend/widgets/rejected_user_button_row.dart';

enum JourneyItemType {
  pending,
  accepted,
  declined,
  pendingOthersJourney,
  acceptedOthersJourney,
  declinedOthersJourney,
  noRequests,
  cancelled
}

class JourneyItem extends StatelessWidget {
  final JourneyItemType type;
  final JourneyReadViewModel journey;
  final UserReadViewModel user;
  final void Function() refreshParent;
  String _text;

  JourneyItem(this.type, [this.journey, this.refreshParent, this.user]) {
    switch (this.type) {
      case JourneyItemType.pending:
        {
          _text = "${user.username} interessiert sich für diese Fahrt!";
        }
        break;
      case JourneyItemType.accepted:
        {
          _text = "Du hast ${user.username} für diese Fahrt angenommen";
        }
        break;
      case JourneyItemType.declined:
        {
          _text = "Du hast ${user.username} für diese Fahrt abgelehnt";
        }
        break;
      case JourneyItemType.pendingOthersJourney:
        {
          _text = "Du hast diese Fahrt angefragt";
        }
        break;
      case JourneyItemType.acceptedOthersJourney:
        {
          _text = "Du wurdest für diese Fahrt angenommen";
        }
        break;
      case JourneyItemType.declinedOthersJourney:
        {
          _text = "Du wurdest für diese Fahrt abgelehnt";
        }
        break;
      case JourneyItemType.noRequests:
        {
          _text = "Für diese Fahrt gibt es noch keine Anfragen";
        }
        break;
      case JourneyItemType.cancelled:
        {
          _text =
              "Du hast diese Fahrt abgesagt:\n${journey.cancelledByHostReason}";
        }
        break;

      default:
        {
          _text = "";
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.only(left: 7, right: 7),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(Icons.subdirectory_arrow_right),
                ),
                Expanded(
                    child: Center(
                        child: Column(children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(_text),
                  ),
                  (() {
                    switch (this.type) {
                      case JourneyItemType.pending:
                        {
                          return PendingUserButtonRow(
                              journey.id, user.id, refreshParent);
                        }
                        break;
                      case JourneyItemType.accepted:
                        {
                          return AcceptedUserButtonRow(
                              journey.id, user.id, refreshParent);
                        }
                        break;
                      case JourneyItemType.declined:
                        {
                          return RejectedUserButtonRow(
                              journey.id, user.id, refreshParent);
                        }
                        break;
                      case JourneyItemType.pendingOthersJourney:
                        {
                          return PendingOthersJourneyButtonRow(
                              journey.id, refreshParent);
                        }
                        break;
                      case JourneyItemType.acceptedOthersJourney:
                        {
                          return AcceptedOthersJourneyButtonRow(
                              journey.id, refreshParent);
                        }
                        break;
                      case JourneyItemType.declinedOthersJourney:
                        {
                          return DeclinedOthersJourneyButtonRow(refreshParent);
                        }
                        break;
                      case JourneyItemType.noRequests:
                        {
                          return SizedBox.shrink();
                        }
                        break;
                      case JourneyItemType.cancelled:
                        {
                          return SizedBox.shrink();
                        }
                        break;
                      default:
                        {
                          return SizedBox.shrink();
                        }
                        break;
                    }
                  }()),
                ])))
              ],
            )));
  }
}
