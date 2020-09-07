import 'package:flutter/material.dart';
import 'package:home/components/items.dart';

class ActionsPage extends StatelessWidget {
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
                "Actions",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ListItem("Action", null);
            },
            childCount: 22,
          ),
        ),
      ],
    );
  }
}
