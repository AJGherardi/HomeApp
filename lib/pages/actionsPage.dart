import 'package:flutter/material.dart';
import 'package:home/components/items.dart';

class ActionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: 100.0,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(
              'Actions',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(top: 12),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListItem("Action", null);
              },
              childCount: 22,
            ),
          ),
        )
      ],
    );
  }
}
