import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/components/buttons.dart';
import 'package:home/components/items.dart';
import 'package:home/components/routes.dart';
import 'package:home/pages/eventBindPage.dart';
import 'package:home/pages/mainPage.dart';
import 'package:home/services/graphql.dart';

String addGroup = """
  mutation AddGroup(\$name: String!) {
    addGroup(name: \$name) {
      name
      addr
    }
  }
""";

String getUserPin = """
  query getUserPin {
    getUserPin
  }
""";

void showSheet(context, childern) {
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
          children: childern,
        ),
      );
    },
  );
}

void showAddUserSheet(context) {
  showSheet(
    context,
    <Widget>[
      SizedBox(height: 24),
      Text(
        "Add User",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline1,
      ),
      SizedBox(height: 24),
      Text(
        "Give this pin to the user you wish to add",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      SizedBox(height: 48),
      Query(
        options: QueryOptions(
          documentNode: gql(getUserPin),
          variables: {},
        ),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          if (result.loading) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            );
          }
          final pin = result.data["getUserPin"];
          return Text(
            pin.toString(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          );
        },
      ),
      SizedBox(height: 48),
    ],
  );
}

void showAddGroupSheet(context) {
  var nameText = "";
  showSheet(
    context,
    <Widget>[
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
                'name': nameText,
              });
            },
          );
        },
      ),
      SizedBox(height: 24),
    ],
  );
}

void showDeviceSheet(context, name, addr) {
  showSheet(
    context,
    <Widget>[
      SizedBox(height: 24),
      Text(
        name,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline1,
      ),
      SizedBox(height: 24),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "address:",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            addr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
      SizedBox(height: 24),
    ],
  );
}

void showEventSheet(context, name, addr, groupAddr) {
  showSheet(
    context,
    <Widget>[
      SizedBox(height: 24),
      Text(
        name,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline1,
      ),
      SizedBox(height: 24),
      Query(
        options: QueryOptions(
          documentNode: gql(getState),
          variables: {
            'addr': addr,
          },
        ),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          if (result.loading) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            );
          }
          final scene = result.data["getState"];
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "scene:",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              ListItem(scene == "AA==" ? "Event" : scene, () {
                Navigator.push(
                  context,
                  FadeRoute(
                    builder: (context) => EventBindPage(groupAddr, addr),
                  ),
                );
              }),
            ],
          );
        },
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "address:",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            addr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
      SizedBox(height: 24),
    ],
  );
}

void showSceneSheet(context, name, addr, number) {
  showSheet(
    context,
    <Widget>[
      SizedBox(height: 24),
      Text(
        name,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline1,
      ),
      SizedBox(height: 24),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "group address:",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            addr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "scene number:",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            number,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
      SizedBox(height: 24),
    ],
  );
}
