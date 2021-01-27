import 'package:flutter/material.dart';
import 'formatted_address.dart';

class AddressTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(children: <Widget>[
          Text("Von:"),
          FormattedAddress("Musterstraße, Berlin"),
        ],
        ),
        TableRow(children: <Widget>[
          Text("Nach:"),
          FormattedAddress("another Address, Berlin"),
        ],
        )
      ],
    );
  }
}
