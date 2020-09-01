import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home/components/buttons.dart';
import 'package:home/components/routes.dart';
import 'package:home/pages/availableHubsPage.dart';

class AddHubSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                "Add Hub",
                style: Theme.of(context).textTheme.headline1,
              ),
              SvgPicture.asset(
                "assets/devices.svg",
                width: 260,
              ),
              NextButton(
                "Next",
                () {
                  Navigator.push(
                    context,
                    FadeRoute(
                      builder: (context) => AvailableHubsPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
