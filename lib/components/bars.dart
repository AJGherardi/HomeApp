import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopBar extends StatelessWidget {
  TopBar(this.text, this.rightIcon, this.onPress);
  final String text;
  final IconData rightIcon;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TopIcon(Icons.chevron_left, () {
          Navigator.pop(context);
        }),
        Text(
          text,
          style: GoogleFonts.oleoScript(
            fontSize: 52,
            color: Colors.black,
          ),
        ),
        TopIcon(rightIcon, onPress)
      ],
    );
  }
}

class TopIcon extends StatelessWidget {
  TopIcon(this.icon, this.onPressed);
  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      iconSize: 36,
      color: Colors.black,
      onPressed: onPressed,
    );
  }
}
