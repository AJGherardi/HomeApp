import 'package:flutter/material.dart';
import 'package:home/components/dialogs.dart';
import 'package:home/components/items.dart';
import 'package:home/components/routes.dart';
import 'package:home/pages/addDeviceSplash.dart';
import 'package:home/pages/addGroupSplash.dart';

class ManagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: 100.0,
          backgroundColor: Colors.grey[50],
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(
              'Manage',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: ListItem("Add Device", () {
            Navigator.push(
              context,
              FadeRoute(builder: (context) => AddDeviceSplash()),
            );
          }),
        ),
        SliverToBoxAdapter(
          child: ListItem("Add Group", () {
            Navigator.push(
              context,
              FadeRoute(builder: (context) => AddGroupSplash()),
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
