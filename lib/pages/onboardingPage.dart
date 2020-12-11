import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/components/routes.dart';
import 'package:home/components/switcher.dart';
import 'package:home/graphql/graphql.dart';
import 'package:home/pages/addHubPage.dart';
import 'package:home/pages/availableHubsPage.dart';
import 'package:home/pages/mainPage.dart';
import 'package:home/pages/welcomePage.dart';
import 'package:home/services/graphql.dart';
import 'package:home/services/store.dart';
import 'package:provider/provider.dart';

class OnboardingModel {
  bool provisioned;
  int pin;
}

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final List<Widget> _children = [
    WelcomePage(),
    AvailableHubsPage(),
    AddHubPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Provider<OnboardingModel>(
      create: (_) {
        return new OnboardingModel();
      },
      builder: (context, _) {
        return PageSwitcher(
          children: _children,
          doneButton: MutationWithBuilder(
            onCompleted: (resultData) async {
              // Get webKey from result
              final data = resultData as Map<String, Object>;
              final webKey = data["configHub"];
              // Set webKey in provider
              Provider.of<ClientModel>(context, listen: false).webKey = webKey;
              // Save data for future use
              await saveConnectionData(
                Provider.of<ClientModel>(context, listen: false).host,
                Provider.of<ClientModel>(context, listen: false).webKey,
              );
              // Navagate to HomePage
              Navigator.push(
                context,
                FadeRoute(
                  builder: (context) => MainPage(),
                ),
              );
            },
            query: configHubMutation,
            builder: (
              RunMutation runConfigHub,
              QueryResult result,
            ) {
              return MutationWithBuilder(
                query: addUserMutation,
                onCompleted: (resultData) async {
                  // Get webKey from result
                  final data = resultData as Map<String, Object>;
                  final webKey = data["addUser"];
                  // Set webKey in provider
                  Provider.of<ClientModel>(context, listen: false).webKey =
                      webKey;
                  // Save data for future use
                  await saveConnectionData(
                    Provider.of<ClientModel>(context, listen: false).host,
                    Provider.of<ClientModel>(context, listen: false).webKey,
                  );
                  // Navagate to HomePage
                  Navigator.push(
                    context,
                    FadeRoute(
                      builder: (context) => MainPage(),
                    ),
                  );
                },
                builder: (
                  RunMutation runAddUser,
                  QueryResult result,
                ) {
                  return Container(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () {
                        if (Provider.of<ClientModel>(context, listen: false)
                                .host !=
                            "") {
                          if (Provider.of<OnboardingModel>(context,
                                      listen: false)
                                  .provisioned ==
                              false) {
                            runConfigHub({});
                          } else {
                            runAddUser({
                              'pin': Provider.of<OnboardingModel>(context,
                                      listen: false)
                                  .pin,
                            });
                          }
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.all(12),
                        child: Text(
                          "Done",
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
