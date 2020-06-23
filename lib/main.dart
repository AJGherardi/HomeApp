import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home/pages/welcomePage.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomePage(),
    );
  }
}
