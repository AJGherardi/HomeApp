import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  TopBar(
    this.text,
    this.rightIcon,
  );
  final String text;
  final IconData rightIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: TopIcon(Icons.chevron_left, () {
              Navigator.pop(context);
            }),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Text(text, style: Theme.of(context).textTheme.headline1),
          ),
        ],
      ),
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
      iconSize: 32,
      color: Theme.of(context).textTheme.headline1.color,
      onPressed: onPressed,
    );
  }
}
