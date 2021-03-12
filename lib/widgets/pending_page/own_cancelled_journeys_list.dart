import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/view-models/journey_read_view_model.dart';
import 'package:traveltogether_frontend/widgets/request_and_offer_card.dart';

import 'journey_item.dart';

class OwnCancelledJourneysList extends StatelessWidget {
  final List<JourneyReadViewModel> journeys;
  final void Function() refreshParent;
  final bool isFirstItem;

  OwnCancelledJourneysList(
      this.journeys, this.refreshParent, this.isFirstItem);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: journeys.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              (() {
                if (isFirstItem && index == 0) {
                  return RequestAndOfferCard(
                      journeys[index], refreshParent, null, false);
                } else {
                  return Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: RequestAndOfferCard(
                          journeys[index], refreshParent, null, false));
                }
              }()),
              JourneyItem(JourneyItemType.cancelled, journeys[index])
            ],
          );
        });
  }
}
