import 'package:flutter/material.dart';
import 'package:home/components/dialogs.dart';
import 'package:home/components/items.dart';
import 'package:home/components/routes.dart';
import 'package:home/components/sheets.dart';
import 'package:home/pages/addDevicePage.dart';
import 'package:home/pages/addScenePage.dart';

class ManagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                15,
                MediaQuery.of(context).padding.top + 15,
                15,
                15,
              ),
              child: Text(
                "Manage",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: ListItem("Add Device", () {
            Navigator.push(
              context,
              FadeRoute(builder: (context) => AddDevicePage()),
            );
          }),
        ),
        SliverToBoxAdapter(
          child: ListItem("Add Group", () {
            showAddGroupSheet(context);
          }),
        ),
        SliverToBoxAdapter(
          child: ListItem("Add Scene", () {
            Navigator.push(
              context,
              FadeRoute(builder: (context) => AddScenePage()),
            );
          }),
        ),
        SliverToBoxAdapter(
          child: ListItem("Reset", () {
            showResetDialog(context);
          }),
        )
      ],
    );
  }
}
