import 'package:flutter/material.dart';

class CancelJourneyPopUp extends StatefulWidget {
  TextEditingController controller;

  CancelJourneyPopUp() {
    controller = new TextEditingController();
  }

  @override
  _CancelJourneyPopUpState createState() => _CancelJourneyPopUpState();
}

class _CancelJourneyPopUpState extends State<CancelJourneyPopUp> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
      title: Text(
        "Fahrt absagen",
      ),
      content: Column(
        children: [
          Text(
            "Warum sagst du diese Fahrt ab?",
            style: TextStyle(color: Colors.black),
          ),
          TextFormField(
              controller: this.widget.controller,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: MediaQuery.of(context).viewInsets.bottom == 0 ? 23 : 5,
              validator: (value) {
                if (value.isEmpty) {
                  return "Bitte gib einen Grund an";
                }
                return null;
              })
        ],
      ),
      //backgroundColor: Colors.white,
      actions: [
        TextButton(
          child: Text(
            "Abbrechen",
            style: TextStyle(color: Colors.blueAccent),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text(
            "Bestätigen",
            style: TextStyle(color: Colors.blueAccent),
          ),
          onPressed: () {
            if(_formKey.currentState.validate()) {
              Navigator.pop(context, widget.controller.text);
            }
          },
        ),
      ],
    )
    );
  }
}
