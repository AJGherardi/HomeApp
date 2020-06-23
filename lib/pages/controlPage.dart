import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/components/items.dart';
import 'package:home/pages/devicePage.dart';

class ControlPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Center(
            child: Container(
              margin: EdgeInsets.all(36),
              child: Text(
                "Control",
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
              return Column(
                children: <Widget>[
                  Text(
                    "Room",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w900,
                      fontSize: 26,
                    ),
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(12.0),
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 24,
                    crossAxisCount: 2,
                    children: <Widget>[
                      Item("Device", DevicePage()),
                      Item("Device", DevicePage()),
                      Item("Device", DevicePage()),
                      Item("Device", DevicePage()),
                    ],
                  ),
                ],
              );
            },
            childCount: 22,
          ),
        )
      ],
    );
  }
}
