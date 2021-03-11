import 'package:flutter/material.dart';
import 'formatted_address.dart';

class AddressTable extends StatelessWidget {
  final String startAddress;
  final String endAddress;
  final bool areAnonymized;

  AddressTable(this.startAddress, this.endAddress, this.areAnonymized);

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: <Widget>[
            Text(
              "Von:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: FormattedAddress(startAddress, areAnonymized)),
          ],
        ),
        TableRow(
          children: <Widget>[
            Text(
              "Nach:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            FormattedAddress(endAddress, areAnonymized),
          ],
        )
      ],
    );
  }
}
