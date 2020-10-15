import 'package:flutter/material.dart';
import 'package:home/components/items.dart';
import 'package:home/components/title.dart';

class ActionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Center(child: TitleText(text: "Actions")),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ListItem(text: "Action", onTap: null);
            },
            childCount: 22,
          ),
        ),
      ],
    );
  }
}
