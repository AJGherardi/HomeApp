import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/components/items.dart';
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
          ListItem("Add Device", AddDeviceSplash()),
          ListItem("Add Group", AddGroupSplash()),
          ListItem("Remove Deivce", AddGroupSplash()),
          ListItem("Remove Group", AddGroupSplash()),
          ListItem("Reset", AddGroupSplash()),
        ],
      ),
    );
  }
}
