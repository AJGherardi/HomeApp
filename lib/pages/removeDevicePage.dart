import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/components/switcher.dart';
import 'package:home/graphql/graphql.dart';
import 'package:home/pages/availableGroupsPage.dart';
import 'package:home/pages/devicesPage.dart';
import 'package:home/services/graphql.dart';
import 'package:provider/provider.dart';

class RemoveDeviceModel {
  num groupAddr;
  num devAddr;
}

class RemoveDevicePage extends StatefulWidget {
  @override
  _RemoveDevicePageState createState() => _RemoveDevicePageState();
}

class _RemoveDevicePageState extends State<RemoveDevicePage> {
  final List<Widget> _children = [
    AvailableGroupsPage(
      onSelected: (context, addr) {
        Provider.of<RemoveDeviceModel>(context, listen: false).groupAddr = addr;
      },
      checkSelected: (context, addr) {
        return Provider.of<RemoveDeviceModel>(context, listen: false)
                .groupAddr ==
            addr;
      },
    ),
    DevicesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Provider<RemoveDeviceModel>(
      create: (_) {
        var model = RemoveDeviceModel();
        model.groupAddr = 0;
        model.devAddr = 0;
        return model;
      },
      builder: (context, _) {
        return PageSwitcher(
          children: _children,
          doneButton: MutationWithBuilder(
            onCompleted: (resultData) {
              // Get name and addr from result
              var data = resultData["removeDevice"];
            },
            query: removeDeviceMutation,
            builder: (
              RunMutation runMutation,
              QueryResult result,
            ) {
              return Container(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: () {
                    runMutation({
                      'groupAddr':
                          Provider.of<RemoveDeviceModel>(context, listen: false)
                              .groupAddr,
                      'devAddr':
                          Provider.of<RemoveDeviceModel>(context, listen: false)
                              .devAddr,
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
