import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'address_table.dart';
import 'formatted_date_time.dart';

class RequestAndOfferCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(7),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(bottom: 7), child: AddressTable()),
            Padding(
              padding: EdgeInsets.only(bottom: 7),
              child: Row(
                children: [
                  FormattedDateTime("starttime"),
                  FormattedDateTime("endtime"),
                ],
              ),
            ),
            Text("Notiz"),
            Text(
                "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea."),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: ElevatedButton(
                      onPressed: null, child: Text("Interessiert mich")),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: ElevatedButton(
                    onPressed: null,
                    child: Text("Chat"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
