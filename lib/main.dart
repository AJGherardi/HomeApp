import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.grey[50],
          statusBarIconBrightness: Brightness.dark),
    );
    // Check if model is returned
    if (Provider.of<ClientModel>(context) == null) {
      return MaterialApp(
        home: Container(
          color: Colors.grey[50],
        ),
      );
    }
    return GraphQLProvider(
      client: Provider.of<ClientModel>(context).client,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: Colors.grey[50],
          // backgroundColor: Colors.white,
          textTheme: TextTheme(
            headline1: TextStyle(
              color: Colors.black,
              fontFamily: "Rubik",
              fontSize: 36,
              fontWeight: FontWeight.w500,
            ),
            headline2: TextStyle(
              color: Colors.black,
              fontFamily: "Rubik",
              fontSize: 26,
              fontWeight: FontWeight.w500,
            ),
            subtitle1: TextStyle(
              color: Colors.black,
              fontFamily: "Rubik",
              fontSize: 28,
              fontWeight: FontWeight.w500,
            ),
            bodyText1: TextStyle(
              color: Colors.black,
              fontFamily: "Rubik",
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
            bodyText2: TextStyle(
              color: Colors.grey,
              fontFamily: "Rubik",
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
            caption: TextStyle(
              fontFamily: "Rubik",
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
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
