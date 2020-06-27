import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/components/items.dart';
import 'package:home/components/routes.dart';
import 'package:home/pages/addDeviceSplash.dart';
import 'package:home/pages/addGroupSplash.dart';

class ManagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.all(24),
              child: Text(
                "Manage",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w900,
                  fontSize: 34,
                ),
              ),
            ),
          ),
          ListItem("Add Device", () {
            Navigator.push(
              context,
              FadeRoute(builder: (context) => AddDeviceSplash()),
            );
          }),
          ListItem("Add Group", () {
            Navigator.push(
              context,
              FadeRoute(builder: (context) => AddGroupSplash()),
            );
          }),
          ListItem("Remove Deivce", () {
            Navigator.push(
              context,
              FadeRoute(builder: (context) => AddDeviceSplash()),
            );
          }),
          ListItem("Remove Group", () {
            Navigator.push(
              context,
              FadeRoute(builder: (context) => AddDeviceSplash()),
            );
          }),
          ListItem("Reset", () {
            Navigator.push(
              context,
              FadeRoute(builder: (context) => AddDeviceSplash()),
            );
          }),
        ],
      ),
    );
  }
}
