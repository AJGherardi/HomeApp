import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/components/buttons.dart';
import 'package:home/components/routes.dart';
import 'package:home/pages/homePage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

String configHub = """
  mutation ConfigHub {
    configHub
  }
""";



class AddHubPage extends StatelessWidget {
  final String host;

  ValueNotifier<GraphQLClient> makeClient() {
    print("http://" + this.host + ":8080/graphql");
    return ValueNotifier(
      GraphQLClient(
        cache: InMemoryCache(),
        link: HttpLink(uri: "http://" + "192.168.1.204" + ":8080/graphql"),
      ),
    );
  }

  AddHubPage({Key key, @required this.host}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: makeClient(),
      child: SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                "Add Hub",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w900,
                  fontSize: 48,
                  color: Colors.black,
                ),
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
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w900,
                        fontSize: 36,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 24)
                  ],
                ),
              ),
              Mutation(
                options: MutationOptions(
                  documentNode: gql(configHub),
                  onCompleted: (dynamic resultData) {
                    print(resultData);
                  },
                  onError: (OperationException error) {
                    print(error);
                  },
                  update: (Cache cache, QueryResult result) {
                    return cache;
                  },
                ),
                builder: (
                  RunMutation runMutation,
                  QueryResult result,
                ) {
                  return NextButton(
                    "Add",
                    () {
                      runMutation({});
                      // Navigator.push(
                      //   context,
                      //   FadeRoute(
                      //     builder: (context) => HomePage(),
                      //   ),
                      // );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
