import 'package:flutter/material.dart';
import 'formatted_address.dart';

class AddressTable extends StatelessWidget {
  final String startAddress;
  final String endAddress;

  AddressTable(this.startAddress, this.endAddress);

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: <Widget>[
            Text("Von:"),
            Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: FormattedAddress(startAddress)),
          ],
        ),
        TableRow(
          children: <Widget>[
            Text("Nach:"),
            FormattedAddress(endAddress),
          ],
        )
      ],
    );
  }
}
