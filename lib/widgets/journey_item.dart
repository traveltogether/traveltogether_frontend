import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/view-models/user_read_view_model.dart';
import 'package:traveltogether_frontend/widgets/accepted_user_button_row.dart';
import 'package:traveltogether_frontend/widgets/pending_user_button_row.dart';
import 'package:traveltogether_frontend/widgets/rejected_user_button_row.dart';

enum JourneyItemType {
  pending,
  accepted,
  declined
}

class JourneyItem extends StatelessWidget {
  final JourneyItemType type;
  final UserReadViewModel user;
  final void Function() refreshParent;
  String _text;

  JourneyItem(this.type, this.user, this.refreshParent) {
    switch(this.type) {
      case JourneyItemType.pending: {
        _text = "${user.username} interessiert sich für diese Fahrt!";
      }
      break;
      case JourneyItemType.accepted: {
        _text = "Du hast ${user.username} für diese Fahrt angenommen";
      }
      break;
      case JourneyItemType.declined: {
        _text = "Du hast ${user.username} für diese Fahrt abgelehnt";
      }
      break;
      default: {
        _text = "";
      }
      break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(7),
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
                            switch(this.type) {
                              case JourneyItemType.pending: {
                                return PendingUserButtonRow();
                              }
                              break;
                              case JourneyItemType.accepted: {
                                return AcceptedUserButtonRow();
                              }
                              break;
                              case JourneyItemType.declined: {
                                return RejectedUserButtonRow();
                              }
                              break;
                              default: {
                                return null;
                              }
                              break;
                            }
                          }()),
                ])))
              ],
            )));
  }
}
