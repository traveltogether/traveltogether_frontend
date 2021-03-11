import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/user_service.dart';
import 'package:traveltogether_frontend/view-models/journey_read_view_model.dart';
import 'package:traveltogether_frontend/view-models/user_read_view_model.dart';
import 'package:traveltogether_frontend/widgets/pending_page/journey_item.dart';

class PendingAcceptedDeclinedUsersList extends StatelessWidget {
  final List<int> users;
  final JourneyReadViewModel journey;
  final JourneyItemType journeyItemType;
  final void Function() refreshParent;
  UserService userService;

  PendingAcceptedDeclinedUsersList(
      this.users, this.journey, this.journeyItemType, this.refreshParent) {
    userService = new UserService();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: users.length,
        itemBuilder: (context, index) {
          return FutureBuilder<UserReadViewModel>(
              future: userService.getUser(users[index]),
              builder: (BuildContext context,
                  AsyncSnapshot<UserReadViewModel> snapshot2) {
                if (!snapshot2.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return JourneyItem(
                      journeyItemType, journey, refreshParent, snapshot2.data);
                }
              });
        });
  }
}
