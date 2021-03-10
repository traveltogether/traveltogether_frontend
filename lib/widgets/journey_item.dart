import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/view-models/journey_read_view_model.dart';
import 'package:traveltogether_frontend/view-models/user_read_view_model.dart';
import 'package:traveltogether_frontend/widgets/accepted_others_journey_button_row.dart';
import 'package:traveltogether_frontend/widgets/accepted_user_button_row.dart';
import 'package:traveltogether_frontend/widgets/declined_others_journey_button_row.dart';
import 'package:traveltogether_frontend/widgets/pending_others_journey_button_row.dart';
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
  cancelled,
  othersCancelled
}

class JourneyItem extends StatelessWidget {
  final JourneyItemType type;
  final JourneyReadViewModel journey;
  final UserReadViewModel user;
  final int currentUserId;
  final void Function() refreshParent;
  String text;
  String reason;
  Color color = Colors.black;

  JourneyItem(this.type,
      [this.journey, this.refreshParent, this.user, this.currentUserId]) {
    switch (this.type) {
      case JourneyItemType.pending:
        {
          text = "${user.username} interessiert sich für diese Fahrt!";
        }
        break;
      case JourneyItemType.accepted:
        {
          text = "Du hast ${user.username} für diese Fahrt angenommen";
        }
        break;
      case JourneyItemType.declined:
        {
          text = "Du hast ${user.username} für diese Fahrt abgelehnt";
        }
        break;
      case JourneyItemType.pendingOthersJourney:
        {
          text = "Du hast diese Fahrt angefragt";
        }
        break;
      case JourneyItemType.acceptedOthersJourney:
        {
          text = "Du wurdest für diese Fahrt angenommen";
        }
        break;
      case JourneyItemType.declinedOthersJourney:
        {
          text = "Du wurdest für diese Fahrt abgelehnt";
        }
        break;
      case JourneyItemType.noRequests:
        {
          text = "Für diese Fahrt gibt es noch keine Anfragen";
        }
        break;
      case JourneyItemType.cancelled:
        {
          text = "Du hast diese Fahrt abgesagt:";
          reason = journey.cancelledByHostReason;
          color = Colors.red;
        }
        break;
      case JourneyItemType.othersCancelled:
        {
          text = "Diese Fahrt wurde abgesagt:";
          reason = journey.cancelledByHostReason;
          color = Colors.red;
        }
        break;

      default:
        {
          text = "";
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
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: text,
                          style: TextStyle(color: color),
                        ),
                        if (reason != null)
                          TextSpan(
                            text: "\n${reason}",
                            style: TextStyle(color: Colors.black),
                          )
                      ]))),
                  (() {
                    switch (this.type) {
                      case JourneyItemType.pending:
                        {
                          return PendingUserButtonRow(
                              journey, user.id, refreshParent);
                        }
                        break;
                      case JourneyItemType.accepted:
                        {
                          return AcceptedUserButtonRow(
                              journey, user.id, refreshParent);
                        }
                        break;
                      case JourneyItemType.declined:
                        {
                          return RejectedUserButtonRow(
                              journey, user.id, refreshParent);
                        }
                        break;
                      case JourneyItemType.pendingOthersJourney:
                        {
                          return PendingOthersJourneyButtonRow(
                              journey, currentUserId, refreshParent);
                        }
                        break;
                      case JourneyItemType.acceptedOthersJourney:
                        {
                          return AcceptedOthersJourneyButtonRow(
                              journey, currentUserId, refreshParent);
                        }
                        break;
                      case JourneyItemType.declinedOthersJourney:
                        {
                          return DeclinedOthersJourneyButtonRow(
                              journey, currentUserId, refreshParent);
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
