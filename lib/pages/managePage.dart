import 'package:flutter/material.dart';
import 'package:home/components/dialogs.dart';
import 'package:home/components/items.dart';
import 'package:home/components/routes.dart';
import 'package:home/components/sheets.dart';
import 'package:home/components/title.dart';
import 'package:home/pages/addDevicePage.dart';
import 'package:home/pages/addScenePage.dart';
import 'package:home/pages/removeDevicePage.dart';

class ManagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Center(
            child: TitleText(text: "Manage"),
          ),
        ),
        SliverToBoxAdapter(
          child: ListItem(
            text: "Add Device",
            onTap: () {
              Navigator.push(
                context,
                FadeRoute(builder: (context) => AddDevicePage()),
              );
            },
          ),
        ),
        SliverToBoxAdapter(
          child: ListItem(
            text: "Add Group",
            onTap: () {
              showAddGroupSheet(context);
            },
          ),
        ),
        SliverToBoxAdapter(
          child: ListItem(
            text: "Add Scene",
            onTap: () {
              Navigator.push(
                context,
                FadeRoute(builder: (context) => AddScenePage()),
              );
            },
          ),
        ),
        SliverToBoxAdapter(
          child: ListItem(
            text: "Add User",
            onTap: () {
              showAddUserSheet(context);
            },
          ),
        ),
        SliverToBoxAdapter(
          child: ListItem(
            text: "Remove Device",
            onTap: () {
              Navigator.push(
                context,
                FadeRoute(builder: (context) => RemoveDevicePage()),
              );
            },
          ),
        ),
        SliverToBoxAdapter(
          child: ListItem(
            text: "Reset",
            onTap: () {
              showResetDialog(context);
            },
          ),
        )
      ],
    );
  }
}
