import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/components/buttons.dart';
import 'package:home/components/routes.dart';
import 'package:home/pages/availableHubsPage.dart';
import 'package:home/pages/mainPage.dart';
import 'package:home/pages/welcomePage.dart';
import 'package:home/services/graphql.dart';
import 'package:home/services/store.dart';
import 'package:provider/provider.dart';

String configHub = """
  mutation ConfigHub {
    configHub
  }
""";

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentPage = 0;

  final List<Widget> _children = [WelcomePage(), AvailableHubsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionSwitcher(
        transitionBuilder: (
          Widget child,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return SharedAxisTransition(
            transitionType: SharedAxisTransitionType.horizontal,
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: _children[_currentPage],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        height: 65,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 2),
          ),
          color: Theme.of(context).cardColor,
        ),
        child: Stack(
          children: [
            AnimatedOpacity(
              opacity: (_currentPage != 0) ? 1.0 : 0.0,
              duration: Duration(milliseconds: 150),
              child: Container(
                alignment: Alignment.centerLeft,
                child: FlatButton(
                  onPressed: (_currentPage != 0)
                      ? () {
                          setState(() {
                            _currentPage--;
                          });
                        }
                      : () {},
                  child: Container(
                    margin: EdgeInsets.all(12),
                    child: Text(
                      "Back",
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < 2; i++)
                    if (i == _currentPage) Dot(true) else Dot(false)
                ],
              ),
            ),
            (_currentPage != 1)
                ? Container(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          _currentPage++;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(12),
                        child: Text(
                          "Next",
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                    ),
                  )
                : MutationWithBuilder(
                    onCompleted: (resultData) async {
                      // Get webKey from result
                      final data = resultData as Map<String, Object>;
                      final webKey = data["configHub"];
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
                    query: configHub,
                    builder: (
                      RunMutation runMutation,
                      QueryResult result,
                    ) {
                      return Container(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          onPressed: () {
                            if (Provider.of<ClientModel>(context, listen: false)
                                    .host !=
                                "") {
                              runMutation({});
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
                  ),
          ],
        ),
      ),
    );
  }
}
