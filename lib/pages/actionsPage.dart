import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/components/items.dart';

class ActionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Center(
            child: Container(
              margin: EdgeInsets.all(36),
              child: Text(
                "Actions",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w900,
                  fontSize: 34,
                ),
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
        )
      ],
    );
  }
}
