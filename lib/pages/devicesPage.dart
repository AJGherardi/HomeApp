import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/components/bars.dart';
import 'package:home/components/items.dart';
import 'package:home/components/title.dart';
import 'package:home/pages/controlPage.dart';
import 'package:home/pages/removeDevicePage.dart';
import 'package:provider/provider.dart';

class DevicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Subscription(
      "ListGroup",
      listGroup,
      variables: {
        'addr':
            Provider.of<RemoveDeviceModel>(context, listen: false).groupAddr,
      },
      builder: ({
        bool loading,
        dynamic payload,
        dynamic error,
      }) {
        if (loading) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
            ),
          );
        }
        List devices = payload["listGroup"]["devices"];
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
                child: TitleText(
              text: "Select Device",
            )),
            SliverPadding(
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  // childAspectRatio: 1.4,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return SelectDeviceItem(
                      device: devices[index],
                    );
                  },
                  childCount: devices.length,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
