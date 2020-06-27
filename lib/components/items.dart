import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/components/routes.dart';

class Item extends StatelessWidget {
  Item(this.text, this.page);
  final String text;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(4),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.black),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap: () {
            Navigator.push(
              context,
              FadeRoute(builder: (context) => page),
            );
          },
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SvgPicture.asset(
                  "assets/plug.svg",
                  width: 100,
                ),
                Text(
                  text,
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ControlItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SvgPicture.asset(
              "assets/power.svg",
              width: 120,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "State",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w900,
                    fontSize: 36,
                    color: Colors.black,
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  color: Colors.black,
                  child: Text(
                    'Off',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  ListItem(this.text, this.onTap);
  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Material(
        borderRadius: BorderRadius.circular(4),
        child: Ink(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(4),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: onTap,
            child: Container(
              margin: EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    text,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
