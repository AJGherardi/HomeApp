import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home/pages/addDevicePage.dart';
import 'package:home/pages/onboardingPage.dart';
import 'package:home/services/store.dart';
import 'package:provider/provider.dart';

class AddHubPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(
              15,
              MediaQuery.of(context).padding.top + 15,
              15,
              15,
            ),
            child: Text(
              "Add Hub",
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          (Provider.of<OnboardingModel>(context, listen: false).provisioned ==
                  true)
              ? Text(
                  "Imput pin",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1,
                )
              : Container(),
          (Provider.of<OnboardingModel>(context, listen: false).provisioned ==
                  true)
              ? Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    onChanged: (text) {
                      var pin = int.parse(text);
                      Provider.of<ClientModel>(context, listen: false)
                          .setPin(pin);
                    },
                    style: Theme.of(context).textTheme.caption,
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 3,
                        ),
                      ),
                      hintText: "Type pin",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
