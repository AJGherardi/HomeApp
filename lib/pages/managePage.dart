import 'package:flutter/material.dart';
import 'package:home/components/dialogs.dart';
import 'package:home/components/items.dart';
import 'package:home/components/routes.dart';
import 'package:home/components/sheets.dart';
import 'package:home/pages/addDevicePage.dart';

class ManagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(15),
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
          child: ListItem("Reset", () {
            showResetDialog(context);
          }),
        )
      ],
    );
  }
}
