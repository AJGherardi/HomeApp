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
          centerTitle: true,
          title: Text(
            'Actions',
            style: Theme.of(context).textTheme.headline1,
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
