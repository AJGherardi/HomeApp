import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/components/items.dart';
import 'package:home/components/routes.dart';
import 'package:home/pages/addDevicePage.dart';

class AvailableDevicesPage extends StatelessWidget {
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
                    "Available Devices",
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
                  return ListItem(
                    "Device",
                    () {
                      Navigator.push(
                        context,
                        FadeRoute(
                          builder: (context) => AddDevicePage(),
                        ),
                      );
                    },
                  );
                },
                childCount: 22,
              ),
            )
          ],
        ),
      ),
    );
  }
}
