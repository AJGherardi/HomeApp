import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/components/routes.dart';
import 'package:home/pages/onboardingPage.dart';
import 'package:home/services/graphql.dart';
import 'package:home/services/store.dart';
import 'package:provider/provider.dart';

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
            // textColor: Color(0xFFEF323D),
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
                  runMutation({
                    'webKey':
                        Provider.of<ClientModel>(context, listen: false).webKey,
                  });
                },
              );
            },
          ),
        ],
      );
    },
  );
}
