import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home/pages/homePage.dart';
import 'package:home/pages/welcomePage.dart';
import 'package:home/services/store.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: getAddress(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return WelcomePage();
            }
            return WelcomePage();
          }
          return Container(color: Colors.white);
        },
      ),
    );
  }
}
