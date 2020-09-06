import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home/components/buttons.dart';
import 'package:home/components/sheets.dart';

class AddDevicePage extends StatelessWidget {
  final String groupAddr;
  final String deviceAddr;

  AddDevicePage({Key key, @required this.groupAddr, @required this.deviceAddr})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              "Add Device",
              style: Theme.of(context).textTheme.headline1,
            ),
            Container(
              margin: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.black),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 36),
                  SvgPicture.asset(
                    "assets/range.svg",
                    color: Theme.of(context).primaryColor,
                    width: 250,
                  ),
                  SizedBox(height: 36),
                  Container(
                    margin: EdgeInsets.only(left: 18, right: 18),
                    child: Divider(
                      thickness: 2,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "This may take a minute",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  SizedBox(height: 24)
                ],
              ),
            ),
            NextButton(
              "Add",
              () {
                showAddDeviceSheet(context, groupAddr, deviceAddr);
              },
            ),
          ],
        ),
      ),
    );
  }
}
