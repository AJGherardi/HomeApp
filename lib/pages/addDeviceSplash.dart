import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/components/buttons.dart';
import 'package:home/components/routes.dart';
import 'package:home/pages/availableGroupsPage.dart';

class AddDeviceSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                "Add a Device",
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w900,
                    fontSize: 48,
                    color: Colors.black),
              ),
              SvgPicture.asset(
                "assets/outlet.svg",
                width: 260,
              ),
              NextButton(
                "Next",
                () {
                  Navigator.push(
                    context,
                    FadeRoute(builder: (context) => AvailableGroupsPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
