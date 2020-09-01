import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home/components/buttons.dart';
import 'package:home/components/sheets.dart';

class AddGroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              "Add Group",
              style: Theme.of(context).textTheme.headline1,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.black),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 36),
                  SvgPicture.asset(
                    "assets/range.svg",
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
                    "A group is a collection of devices",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(height: 24)
                ],
              ),
            ),
            NextButton(
              "Add",
              () {
                showAddGroupSheet(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
