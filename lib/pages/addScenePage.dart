import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/components/buttons.dart';
import 'package:home/pages/nameScenePage.dart';
import 'package:home/pages/selectGroupPage.dart';
import 'package:home/services/graphql.dart';
import 'package:home/services/store.dart';
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
  int _currentPage = 0;

  final List<Widget> _children = [
    SelectGroupPage(),
    NameScenePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Provider<AddSceneModel>(create: (_) {
      var model = AddSceneModel();
      model.groupAddr = "";
      model.name = "";
      return model;
    }, builder: (context, _) {
      return Scaffold(
        body: PageTransitionSwitcher(
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return SharedAxisTransition(
              transitionType: SharedAxisTransitionType.horizontal,
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: _children[_currentPage],
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          height: 65,
          decoration: BoxDecoration(
            border: Border(
              top: (Theme.of(context).brightness != Brightness.dark)
                  ? BorderSide(width: 2)
                  : BorderSide.none,
            ),
            color: Theme.of(context).cardColor,
          ),
          child: Stack(
            children: [
              AnimatedOpacity(
                opacity: (_currentPage != 0) ? 1.0 : 0.0,
                duration: Duration(milliseconds: 150),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: FlatButton(
                    onPressed: (_currentPage != 0)
                        ? () {
                            setState(() {
                              _currentPage--;
                            });
                          }
                        : () {},
                    child: Container(
                      margin: EdgeInsets.all(12),
                      child: Text(
                        "Back",
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < 2; i++)
                      if (i == _currentPage) Dot(true) else Dot(false)
                  ],
                ),
              ),
              (_currentPage != 1)
                  ? Container(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            _currentPage++;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(12),
                          child: Text(
                            "Next",
                            style: Theme.of(context).textTheme.button,
                          ),
                        ),
                      ),
                    )
                  : MutationWithBuilder(
                      onCompleted: (resultData) {
                        // Get name and addr from result
                        var data =
                            resultData["addDevice"] as Map<String, Object>;
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
                                'webKey': Provider.of<ClientModel>(context,
                                        listen: false)
                                    .webKey,
                                'name': Provider.of<AddSceneModel>(context,
                                        listen: false)
                                    .name,
                                'addr': Provider.of<AddSceneModel>(context,
                                        listen: false)
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
            ],
          ),
        ),
      );
    });
  }
}
