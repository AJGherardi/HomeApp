import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/components/buttons.dart';
import 'package:home/pages/nameDevicePage.dart';
import 'package:home/pages/availableDevicesPage.dart';
import 'package:home/pages/availableGroupsPage.dart';
import 'package:home/services/graphql.dart';
import 'package:home/services/store.dart';
import 'package:provider/provider.dart';

String addDevice = """
  mutation AddDevice(\$name: String!, \$devUUID: String!, \$addr: String!) {
    addDevice(name: \$name, devUUID: \$devUUID, addr: \$addr) {
      addr
    }
  }
""";

class AddDeviceModel {
  String groupAddr;
  String devUUID;
  String name;
}

class AddDevicePage extends StatefulWidget {
  @override
  _AddDevicePageState createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage> {
  int _currentPage = 0;

  final List<Widget> _children = [
    AvailableGroupsPage(),
    AvailableDevicesPage(),
    NameDevicePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Provider<AddDeviceModel>(
      create: (_) {
        var model = AddDeviceModel();
        model.groupAddr = "";
        model.devUUID = "";
        model.name = "";
        return model;
      },
      builder: (context, _) {
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
                      for (int i = 0; i < 3; i++)
                        if (i == _currentPage) Dot(true) else Dot(false)
                    ],
                  ),
                ),
                (_currentPage != 2)
                    ? Container(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          onPressed: () {
                            if (Provider.of<AddDeviceModel>(context,
                                        listen: false)
                                    .groupAddr !=
                                "") {
                              setState(() {
                                _currentPage++;
                              });
                            }
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
                        query: addDevice,
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
                                  'name': Provider.of<AddDeviceModel>(context,
                                          listen: false)
                                      .name,
                                  'devUUID': Provider.of<AddDeviceModel>(
                                          context,
                                          listen: false)
                                      .devUUID,
                                  'addr': Provider.of<AddDeviceModel>(context,
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
      },
    );
  }
}
