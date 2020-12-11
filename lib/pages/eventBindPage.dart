import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/components/bars.dart';
import 'package:home/components/dialogs.dart';
import 'package:home/components/items.dart';
import 'package:home/graphql/graphql.dart';
import 'package:home/graphql/types.dart';

class EventBindPage extends StatelessWidget {
  EventBindPage(this.groupAddr, this.devAddr, this.elemAddr);

  final num groupAddr;
  final num devAddr;
  final num elemAddr;
  @override
  Widget build(BuildContext context) {
    return Subscription(
      "WatchGroup",
      watchGroupSubscription,
      variables: {
        'addr': groupAddr,
      },
      builder: ({
        bool loading,
        dynamic payload,
        dynamic error,
      }) {
        if (error != null) {
          return ConnectError();
        }
        if (loading) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
            ),
          );
        }
        GroupResponse group = GroupResponse.fromJson(payload["watchGroup"]);
        // Add a no scene option
        SceneResponse eventScene = SceneResponse(0, Scene("Event"));
        group.group.scenes.insert(0, eventScene);
        // Get list of elements
        List groupElements = new List();
        for (var device in group.group.devices) {
          groupElements.addAll(device.device.elements);
        }
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                  ),
                  child: TopBar(
                    text: "Select scene",
                    rightIcon: Icons.arrow_back,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.4,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return SelectSceneItem(
                      name: group.group.scenes[index].scene.name,
                      number: group.group.scenes[index].number,
                      groupAddr: groupAddr,
                      devAddr: devAddr,
                      elemAddr: elemAddr,
                    );
                  },
                  childCount: group.group.scenes.length,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
