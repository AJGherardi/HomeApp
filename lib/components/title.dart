import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  TitleText(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        15,
        MediaQuery.of(context).padding.top + 15,
        15,
        15,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}
