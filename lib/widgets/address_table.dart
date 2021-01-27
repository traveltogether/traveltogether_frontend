import 'package:flutter/material.dart';
import 'formatted_address.dart';

class AddressTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(children: <Widget>[
          Text("Von:"),
          Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: FormattedAddress("Musterstraße 15, 10753 Berlin")
          ),
        ],
        ),
        TableRow(children: <Widget>[
          Text("Nach:"),
          FormattedAddress("another Address 24, 20306 Berlin"),
        ],
        )
      ],
    );
  }
}
