import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/pages/mainPage.dart';
import 'package:home/pages/onboardingPage.dart';
import 'package:home/services/store.dart';
import 'package:provider/provider.dart';

class AppHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = new AppHttpOverrides();
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
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    if (brightness == Brightness.light) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
      );
    }
    // Check if model is returned
    if (Provider.of<ClientModel>(context) == null) {
      return MaterialApp(
        home: Container(
          color: (brightness == Brightness.light)
              ? Colors.grey[50]
              : Color(0xFF121212),
        ),
      );
    }
    return GraphQLProvider(
      client: Provider.of<ClientModel>(context).client,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode:
            (brightness == Brightness.light) ? ThemeMode.light : ThemeMode.dark,
        theme: ThemeData(
          backgroundColor: Colors.grey[50],
          canvasColor: Colors.grey[50],
          cardColor: Colors.grey[50],
          appBarTheme: AppBarTheme(color: Colors.grey[50]),
          buttonTheme: ButtonThemeData(buttonColor: Colors.black),
          primaryColor: Color(0xFFEF323D),
          accentColor: Color(0xFFEF323D),
          tabBarTheme: TabBarTheme(
            indicator: BoxDecoration(),
            labelColor: Color(0xFFEF323D),
            unselectedLabelColor: Colors.black,
            labelStyle: TextStyle(
              fontFamily: "Rubik",
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: "Rubik",
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Color(0xFFEF323D),
            unselectedItemColor: Color(0xBFFFFFFF),
            selectedItemColor: Colors.white,
          ),
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
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          cardColor: Color(0xFF2E2E2E),
          canvasColor: Color(0xFF121212),
          appBarTheme: AppBarTheme(color: Color(0xFF121212)),
          buttonTheme: ButtonThemeData(buttonColor: Colors.black),
          primaryColor: Color(0xFFFF6C68),
          accentColor: Color(0xFFFF6C68),
          tabBarTheme: TabBarTheme(
            indicator: BoxDecoration(),
            labelColor: Color(0xFFFF6C68),
            unselectedLabelColor: Colors.white,
            labelStyle: TextStyle(
              fontFamily: "Rubik",
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: "Rubik",
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Color(0xFF2E2E2E),
            unselectedItemColor: Color(0xBFFFFFFF),
            selectedItemColor: Color(0xFFFF6C68),
          ),
          backgroundColor: Colors.grey[50],
          textTheme: TextTheme(
            headline1: TextStyle(
              color: Colors.white,
              fontFamily: "Rubik",
              fontSize: 36,
              fontWeight: FontWeight.w500,
            ),
            headline2: TextStyle(
              color: Colors.white,
              fontFamily: "Rubik",
              fontSize: 26,
              fontWeight: FontWeight.w500,
            ),
            subtitle1: TextStyle(
              color: Colors.white,
              fontFamily: "Rubik",
              fontSize: 28,
              fontWeight: FontWeight.w500,
            ),
            bodyText1: TextStyle(
              color: Colors.white,
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
              color: Colors.white,
              fontFamily: "Rubik",
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            button: TextStyle(
              color: Colors.white,
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
              return OnboardingPage();
            }
            // Else return the home page
            return MainPage();
          },
        ),
      ),
    );
  }
}
