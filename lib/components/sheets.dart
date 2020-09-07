import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/components/buttons.dart';
import 'package:home/components/routes.dart';
import 'package:home/pages/mainPage.dart';
import 'package:home/services/graphql.dart';
import 'package:home/services/store.dart';
import 'package:provider/provider.dart';

String addGroup = """
  mutation AddGroup(\$name: String!) {
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
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(height: 24),
            TextField(
              onChanged: (text) {
                nameText = text;
              },
              style: Theme.of(context).textTheme.caption,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 3,
                  ),
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
                    builder: (context) => MainPage(),
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

void showDeviceSheet(context, name) {
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
              name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(height: 24),
          ],
        ),
      );
    },
  );
}
