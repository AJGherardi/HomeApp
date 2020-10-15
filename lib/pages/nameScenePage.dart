import 'package:flutter/material.dart';
import 'package:home/components/title.dart';
import 'package:home/pages/addScenePage.dart';
import 'package:provider/provider.dart';

class NameScenePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TitleText("Add Scene"),
          Text(
            "Set Name",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: TextField(
              onChanged: (text) {
                Provider.of<AddSceneModel>(context, listen: false).name = text;
              },
              style: Theme.of(context).textTheme.caption,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 3,
                  ),
                ),
                hintText: "Type name hear",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
