import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/components/buttons.dart';
import 'package:home/components/routes.dart';
import 'package:home/pages/addHubSplash.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Stack(
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Home",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w900,
                        fontSize: 64,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "By",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 30,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Alexander Gherardi",
                      style: GoogleFonts.oleoScript(
                        fontWeight: FontWeight.w400,
                        fontSize: 30,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.all(24),
                  child: NextButton(
                    "Next",
                    () {
                      Navigator.push(
                        context,
                        FadeRoute(
                          builder: (context) => AddHubSplash(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
