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

class Dot extends StatelessWidget {
  Dot(this.isActive);

  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 3.3),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: isActive ? Theme.of(context).primaryColor : Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
