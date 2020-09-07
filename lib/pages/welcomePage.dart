import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome ",
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(
                "Home",
                style: Theme.of(context).textTheme.headline1.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
