import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/components/buttons.dart';
import 'package:home/components/routes.dart';
import 'package:home/pages/homePage.dart';
import 'package:home/services/graphql.dart';
import 'package:home/services/store.dart';
import 'package:provider/provider.dart';

String addGroup = """
  mutation AddGroupMutation(\$name: String!) {
    addGroup(name: \$name) {
      name
      addr
    }
  }
""";

void showAddGroupSheet(context) {
  var nameText = "";
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(14),
        topRight: Radius.circular(14),
      ),
    ),
    context: context,
    builder: (BuildContext bc) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          right: 24,
          left: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 24),
            Text(
              "Set Name",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w900,
                fontSize: 36,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 24),
            TextField(
              onChanged: (text) {
                nameText = text;
              },
              cursorColor: Colors.red[700],
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red[700], width: 3),
                ),
                hintText: "Type name hear",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
            ),
            SizedBox(height: 24),
            MutationWithBuilder(
              onCompleted: (resultData) {
                // Get name and addr from result
                var data = resultData as Map<String, Object>;
                var addGroupResult = data["addGroup"] as Map<String, Object>;
                print(addGroupResult["name"]);
                print(addGroupResult["addr"]);
                Navigator.push(
                  context,
                  FadeRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
              query: addGroup,
              builder: (
                RunMutation runMutation,
                QueryResult result,
              ) {
                return NextButton(
                  "Add",
                  () {
                    runMutation({
                      'webKey': Provider.of<ClientModel>(context, listen: false)
                          .webKey,
                      'name': nameText,
                    });
                  },
                );
              },
            ),
            SizedBox(height: 24),
          ],
        ),
      );
    },
  );
}
