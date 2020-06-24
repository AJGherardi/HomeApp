import 'package:flutter/material.dart';

void showRemoveDialog(context, type) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Remove " + type),
        content: Text(
          "Are you sure you want to remove this " + type,
        ),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.black,
            child: Text("Close"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            textColor: Colors.red[700],
            child: Text("Remove"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
