import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/components/buttons.dart';
import 'package:home/components/routes.dart';
import 'package:home/pages/addGroupPage.dart';

class AddGroupSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                "Add a Group",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w900,
                  fontSize: 48,
                  color: Colors.black,
                ),
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
                    FadeRoute(builder: (context) => AddGroupPage()),
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
