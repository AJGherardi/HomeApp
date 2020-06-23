import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/components/items.dart';
import 'package:home/pages/addHubPage.dart';

class AvailableHubsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(36),
                  child: Text(
                    "Available Hubs",
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
                  return ListItem("Hub", AddHubPage());
                },
                childCount: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
