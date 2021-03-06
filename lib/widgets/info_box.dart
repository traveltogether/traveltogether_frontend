import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {
  final String text;
  final Color color;

  InfoBox(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
          border: Border.all(color: this.color, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Text(text),
    );
  }
}
