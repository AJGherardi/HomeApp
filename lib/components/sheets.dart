import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/components/buttons.dart';
import 'package:home/components/items.dart';
import 'package:home/components/routes.dart';
import 'package:home/graphql/graphql.dart';
import 'package:home/pages/eventBindPage.dart';
import 'package:home/pages/mainPage.dart';
import 'package:home/services/graphql.dart';

void showSheet(context, childern, double height) {
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
          bottom: height,
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
          documentNode: gql(getUserPinQuery),
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
    MediaQuery.of(context).viewInsets.bottom,
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
          var addGroupResult = data["addGroup"];
          Navigator.push(
            context,
            FadeRoute(
              builder: (context) => MainPage(),
            ),
          );
        },
        query: addGroupMutation,
        builder: (
          RunMutation runMutation,
          QueryResult result,
        ) {
          return NextButton(
            text: "Add",
            onPress: () {
              runMutation({
                'name': nameText,
              });
            },
          );
        },
      ),
      SizedBox(height: 24),
    ],
    220,
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
    MediaQuery.of(context).viewInsets.bottom,
  );
}

void showEventSheet(context, name, groupAddr, devAddr, elemAddr) {
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
          documentNode: gql(watchStateSubscription),
          variables: {
            'groupAddr': groupAddr,
            'devAddr': devAddr,
            'elemAddr': elemAddr,
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
              ListItem(
                text: scene == "AA==" ? "Event" : scene,
                onTap: () {
                  Navigator.push(
                    context,
                    FadeRoute(
                      builder: (context) =>
                          EventBindPage(groupAddr, devAddr, elemAddr),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "element address:",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            elemAddr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
      SizedBox(height: 24),
    ],
    MediaQuery.of(context).viewInsets.bottom,
  );
}

void showSceneSheet(context, name, groupAddr, number) {
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
            groupAddr,
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
    MediaQuery.of(context).viewInsets.bottom,
  );
}
