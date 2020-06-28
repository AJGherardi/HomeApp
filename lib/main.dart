import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/pages/homePage.dart';
import 'package:home/pages/welcomePage.dart';
import 'package:home/services/store.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    FutureProvider<ClientModel>(
      create: (context) => getClientModel(),
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Check if model is returned
    if (Provider.of<ClientModel>(context) == null) {
      return MaterialApp(
        home: Container(
          color: Colors.white,
        ),
      );
    }
    return GraphQLProvider(
      client: Provider.of<ClientModel>(context).client,
      child: MaterialApp(
        home: Builder(
          builder: (context) {
            // Return welcome page if not set up
            if (Provider.of<ClientModel>(context).webKey == null) {
              return WelcomePage();
            }
            // Else return the home page
            return HomePage();
          },
        ),
      ),
    );
  }
}
