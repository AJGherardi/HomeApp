import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/components/switcher.dart';
import 'package:home/pages/nameDevicePage.dart';
import 'package:home/pages/availableDevicesPage.dart';
import 'package:home/pages/availableGroupsPage.dart';
import 'package:home/services/graphql.dart';
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
        return PageSwitcher(
          _children,
          MutationWithBuilder(
            onCompleted: (resultData) {
              // Get name and addr from result
              var data = resultData["addDevice"] as Map<String, Object>;
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
                      'name':
                          Provider.of<AddDeviceModel>(context, listen: false)
                              .name,
                      'devUUID':
                          Provider.of<AddDeviceModel>(context, listen: false)
                              .devUUID,
                      'addr':
                          Provider.of<AddDeviceModel>(context, listen: false)
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
