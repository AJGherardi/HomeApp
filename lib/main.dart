import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/pages/homePage.dart';
import 'package:home/pages/welcomePage.dart';
import 'package:home/services/store.dart';
import 'package:provider/provider.dart';
import 'package:home/services/graphql.dart';

void main() {
  runApp(
    Provider<ClientModel>(create: (context) => ClientModel(), child: App()),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: Provider.of<ClientModel>(context).client,
      child: MaterialApp(
        home: FutureBuilder(
          future: getAddress(),
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null) {
                return WelcomePage();
              }
              Provider.of<ClientModel>(context).setHost(snapshot.data);
              return WelcomePage();
            }
            return Container(color: Colors.white);
          },
        ),
      ),
    );
  }
}
