import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/components/buttons.dart';
import 'package:home/components/routes.dart';
import 'package:home/pages/homePage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/services/graphql.dart';
import 'package:home/services/store.dart';

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
            MutationWithoutWebKey(
              onCompleted: (resultData) {
                // Get webKey from result
                var data = resultData as Map<String, Object>;
                print(data["configHub"]);
                // Save data for future use
                saveConnectionData(host, data["configHub"]);
                // Navagate to HomePage
                Navigator.push(
                  context,
                  FadeRoute(
                    builder: (context) => HomePage(),
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
