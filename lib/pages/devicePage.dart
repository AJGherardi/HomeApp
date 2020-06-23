import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/components/bars.dart';
import 'package:home/components/dialogs.dart';
import 'package:home/components/items.dart';

class DevicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(12),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TopIcon(
                    Icons.chevron_left,
                    () {
                      Navigator.pop(context);
                    },
                  ),
                  TopIcon(
                    Icons.remove_circle_outline,
                    () {
                      showRemoveDialog(context);
                    },
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SvgPicture.asset(
                    "assets/plug.svg",
                    width: 80,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Left outlet",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w900,
                          fontSize: 32,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Living room",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w900,
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24),
              ControlItem(),
              SizedBox(height: 12),
              ControlItem(),
            ],
          ),
        ),
      ),
    );
  }
}
