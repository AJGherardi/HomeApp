import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/components/items.dart';
import 'package:home/components/routes.dart';
import 'package:home/pages/addDevicePage.dart';
import 'package:home/services/store.dart';
import 'package:provider/provider.dart';

String availableDevices = """
  query AvailableDevices {
    availableDevices
  }
""";

class AvailableDevicesPage extends StatelessWidget {
  final String groupAddr;

  AvailableDevicesPage({Key key, @required this.groupAddr}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(36),
                  child: Text(
                    "Available Devices",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w900,
                      fontSize: 34,
                    ),
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
                          Color(0xFFEF323D),
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
                      return ListItem(
                        devices[index],
                        () {
                          Navigator.push(
                            context,
                            FadeRoute(
                              builder: (context) => AddDevicePage(
                                groupAddr: groupAddr,
                                deviceAddr: devices[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    childCount: devices.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
