import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/components/items.dart';
import 'package:home/pages/addDevicePage.dart';
import 'package:home/services/store.dart';
import 'package:provider/provider.dart';

String availableDevices = """
  query AvailableDevices {
    availableDevices
  }
""";

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
              child: Container(
                margin: EdgeInsets.fromLTRB(
                  15,
                  MediaQuery.of(context).padding.top + 15,
                  15,
                  15,
                ),
                child: Text(
                  "Available Devices",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
          ),
          Query(
            options: QueryOptions(
              documentNode: gql(availableDevices),
              variables: {
                'webKey': Provider.of<ClientModel>(context).webKey,
              },
            ),
            builder: (QueryResult result,
                {VoidCallback refetch, FetchMore fetchMore}) {
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
              print(Provider.of<ClientModel>(context).webKey);
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return SelectableListItem(devices[index], () {
                      Provider.of<AddDeviceModel>(context, listen: false)
                          .devUUID = devices[index];
                      setState(() {});
                    },
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
