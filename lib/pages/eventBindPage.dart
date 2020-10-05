import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/components/bars.dart';
import 'package:home/components/items.dart';
import 'package:home/pages/controlPage.dart';

class EventBindPage extends StatelessWidget {
  EventBindPage(this.groupAddr, this.elemAddr);

  final String groupAddr;
  final String elemAddr;
  @override
  Widget build(BuildContext context) {
    return Subscription(
      "ListGroup",
      listGroup,
      variables: {
        'addr': groupAddr,
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
        List scenes = payload["listGroup"]["scenes"];
        print(scenes);
        // Get list of elements
        List groupElements = new List();
        for (var device in devices) {
          groupElements.addAll(device["elements"]);
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
                    "Select scene",
                    Icons.arrow_back,
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
                    return SelectSceneItem(scenes[index]["name"],
                        scenes[index]["number"], groupAddr, elemAddr);
                  },
                  childCount: scenes.length,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
