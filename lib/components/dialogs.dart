import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/components/items.dart' as items;
import 'package:home/components/routes.dart';
import 'package:home/pages/addScenePage.dart';
import 'package:home/pages/onboardingPage.dart';
import 'package:home/services/graphql.dart';
import 'package:home/services/store.dart';

void showRemoveDialog(context, type) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Remove " + type),
        content: Text(
          "Are you sure you want to remove this " + type,
        ),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.black,
            child: Text("Close"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text("Remove"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

String resetHub = """
  mutation ResetHub {
    resetHub
  }
""";

void showResetDialog(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Reset"),
        content: Text(
          "Reseting will remove all devices and groups",
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("Close"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          MutationWithBuilder(
            onCompleted: (resultData) async {
              // Remove connection data
              await deleteConnectionData();
              // Navagate to WelcomePage
              Navigator.push(
                context,
                FadeRoute(
                  builder: (context) => OnboardingPage(),
                ),
              );
            },
            query: resetHub,
            builder: (
              RunMutation runMutation,
              QueryResult result,
            ) {
              return FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text("Reset"),
                onPressed: () {
                  runMutation({});
                },
              );
            },
          ),
        ],
      );
    },
  );
}

class ConnectError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/connect-failed.svg",
            color: Theme.of(context).primaryColor,
            width: 150,
          ),
          Text(
            "Can't connect\n to hub",
            style: Theme.of(context).textTheme.headline1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class AddSceneSuggestion extends StatelessWidget {
  const AddSceneSuggestion({
    @required this.parent,
  });

  final BuildContext parent;
  @override
  Widget build(BuildContext context) {
    return items.Card(
        onTap: () {
          Navigator.of(parent).push(
            FadeRoute(
              builder: (context) => AddScenePage(),
            ),
          );
        },
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/add.svg",
                  color: Theme.of(context).primaryColor,
                  width: 35,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Add a scene",
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ]);
  }
}
