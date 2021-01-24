import 'package:flutter/material.dart';
import 'file:///C:/Users/admin/Documents/FH/SWE_II/traveltogether/traveltogether_frontend/lib/widgets/address_table.dart';
import 'file:///C:/Users/admin/Documents/FH/SWE_II/traveltogether/traveltogether_frontend/lib/widgets/formatted_date_time.dart';

class RequestAndOfferCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            AddressTable(),
            Row(children: [
              FormattedDateTime("starttime"),
              FormattedDateTime("endtime"),
            ],
            ),
            Text("Notiz"),
            Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea."),
            Row(children: [
              ElevatedButton(onPressed: null, child: Text("Interessiert mich")),
              ElevatedButton(onPressed: null, child: Text("Chat"))
            ],)
          ],
        ),
    );
  }
}
