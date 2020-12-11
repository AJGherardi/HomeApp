import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/components/dialogs.dart';
import 'package:home/components/items.dart';
import 'package:home/components/title.dart';
import 'package:home/pages/addDevicePage.dart';
import 'package:provider/provider.dart';
import 'package:home/graphql/graphql.dart';

class AvailableDevicesPage extends StatefulWidget {
  @override
  _AvailableDevicesPageState createState() => _AvailableDevicesPageState();
}

class _AvailableDevicesPageState extends State<AvailableDevicesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Center(
              child: TitleText(text: "Available Devices"),
            ),
          ),
          Query(
            options: QueryOptions(
              documentNode: gql(availableDevicesQuery),
              variables: {},
            ),
            builder: (QueryResult result,
                {VoidCallback refetch, FetchMore fetchMore}) {
              if (result.hasException) {
                return SliverFillRemaining(child: ConnectError());
              }
              if (result.loading) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                );
              }
              List devices = result.data["availableDevices"];
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return SelectableListItem(
                        text: devices[index],
                        onTap: () {
                          Provider.of<AddDeviceModel>(context, listen: false)
                              .devUUID = devices[index];
                          setState(() {});
                        },
                        selected:
                            (Provider.of<AddDeviceModel>(context, listen: false)
                                        .devUUID ==
                                    devices[index])
                                ? true
                                : false);
                  },
                  childCount: devices.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
