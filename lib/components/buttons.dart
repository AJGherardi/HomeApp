import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  NextButton(this.text, this.onPress);
  final String text;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPress,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      color: Colors.black,
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      minWidth: 300,
    );
  }
}
