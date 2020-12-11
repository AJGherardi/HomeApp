import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/components/switcher.dart';
import 'package:home/graphql/graphql.dart';
import 'package:home/pages/availableGroupsPage.dart';
import 'package:home/pages/nameScenePage.dart';
import 'package:home/services/graphql.dart';
import 'package:provider/provider.dart';

class AddSceneModel {
  num groupAddr;
  String name;
}

class AddScenePage extends StatefulWidget {
  @override
  _AddScenePageState createState() => _AddScenePageState();
}

class _AddScenePageState extends State<AddScenePage> {
  final List<Widget> _children = [
    AvailableGroupsPage(
      onSelected: (context, addr) {
        Provider.of<AddSceneModel>(context, listen: false).groupAddr = addr;
      },
      checkSelected: (context, addr) {
        return Provider.of<AddSceneModel>(context, listen: false).groupAddr ==
            addr;
      },
    ),
    NameScenePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Provider<AddSceneModel>(
      create: (_) {
        var model = AddSceneModel();
        model.groupAddr = 0;
        model.name = "";
        return model;
      },
      builder: (context, _) {
        return PageSwitcher(
          children: _children,
          doneButton: MutationWithBuilder(
            onCompleted: (resultData) {
              // Get name and addr from result
              var data = resultData["addScene"];
            },
            query: sceneStoreMutation,
            builder: (
              RunMutation runMutation,
              QueryResult result,
            ) {
              return Container(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: () {
                    runMutation({
                      'name': Provider.of<AddSceneModel>(context, listen: false)
                          .name,
                      'groupAddr':
                          Provider.of<AddSceneModel>(context, listen: false)
                              .groupAddr,
                    });
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: EdgeInsets.all(12),
                    child: Text(
                      "Done",
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
