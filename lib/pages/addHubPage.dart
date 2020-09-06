import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home/components/buttons.dart';
import 'package:home/components/routes.dart';
import 'package:home/pages/mainPage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/services/graphql.dart';
import 'package:home/services/store.dart';
import 'package:provider/provider.dart';

String configHub = """
  mutation ConfigHub {
    configHub
  }
""";

class AddHubPage extends StatelessWidget {
  final String host;

  AddHubPage({Key key, @required this.host}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              "Add Hub",
              style: Theme.of(context).textTheme.headline1,
            ),
            Container(
              margin: EdgeInsets.all(24),
              decoration: BoxDecoration(
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
                    "A hub is required",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  SizedBox(height: 24)
                ],
              ),
            ),
            MutationWithBuilder(
              onCompleted: (resultData) async {
                // Get webKey from result
                final data = resultData as Map<String, Object>;
                final webKey = data["configHub"];
                // Set webKey in provider
                Provider.of<ClientModel>(context, listen: false).webKey =
                    webKey;
                // Save data for future use
                await saveConnectionData(host, webKey);
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
                return NextButton(
                  "Add",
                  () {
                    runMutation({});
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
