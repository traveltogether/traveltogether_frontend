import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/shared/formatted_address.dart';

class AddressTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(children: <Widget>[
          Text("Von:"),
          FormattedAddress("Musterstraße"),
        ],
        ),
        TableRow(children: <Widget>[
          Text("Nach:"),
          FormattedAddress("another Address"),
        ],
        )
      ],
    );
  }
}
