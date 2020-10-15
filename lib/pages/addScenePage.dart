import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/components/switcher.dart';
import 'package:home/pages/nameScenePage.dart';
import 'package:home/pages/selectGroupPage.dart';
import 'package:home/services/graphql.dart';
import 'package:provider/provider.dart';

String sceneStore = """
  mutation SceneStore(\$addr: String!, \$name: String!) {
    sceneStore(addr: \$addr, name: \$name) 
  }
""";

class AddSceneModel {
  String groupAddr;
  String name;
}

class AddScenePage extends StatefulWidget {
  @override
  _AddScenePageState createState() => _AddScenePageState();
}

class _AddScenePageState extends State<AddScenePage> {
  final List<Widget> _children = [
    SelectGroupPage(),
    NameScenePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Provider<AddSceneModel>(
      create: (_) {
        var model = AddSceneModel();
        model.groupAddr = "";
        model.name = "";
        return model;
      },
      builder: (context, _) {
        return PageSwitcher(
          _children,
          MutationWithBuilder(
            onCompleted: (resultData) {
              // Get name and addr from result
              var data = resultData["addDevice"] as Map<String, Object>;
            },
            query: sceneStore,
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
                      'addr': Provider.of<AddSceneModel>(context, listen: false)
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
