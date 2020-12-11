import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/components/bars.dart';
import 'package:home/components/dialogs.dart';
import 'package:home/components/items.dart';
import 'package:home/components/routes.dart';
import 'package:home/graphql/graphql.dart';
import 'package:home/graphql/types.dart';

class ControlPage extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext parent) {
    return Navigator(
      initialRoute: "/",
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => HomePage(navigatorKey, parent),
        );
      },
      key: navigatorKey,
    );
  }
}

class GroupPage extends StatelessWidget {
  GroupPage(this.group, this.navigatorKey, this.parent);

  final GroupResponse group;
  final GlobalKey<NavigatorState> navigatorKey;
  final BuildContext parent;
  @override
  Widget build(BuildContext context) {
    return Subscription(
      "WatchGroup",
      watchGroupSubscription,
      variables: {
        'groupAddr': group.addr,
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
        // Get list of elements
        List<Widget> elementItems = new List();
        for (var device in group.group.devices) {
          for (var element in device.device.elements) {
            if (element.element.stateType == "onoff") {
              elementItems.add(
                OnoffItem(
                  name: element.element.name,
                  groupAddr: group.addr,
                  devAddr: device.addr,
                  elemAddr: element.addr,
                ),
              );
            }
            if (element.element.stateType == "event") {
              return EventItem(
                name: element.element.name,
                groupAddr: group.addr,
                devAddr: device.addr,
                elemAddr: element.addr,
              );
            }
          }
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
                    text: group.group.name,
                    rightIcon: Icons.arrow_back,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(bottom: 15),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    "Scenes",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              ),
            ),
            (group.group.scenes.length != 0)
                ? SliverPadding(
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
                          return SceneItem(
                            name: group.group.scenes[index].scene.name,
                            number: group.group.scenes[index].number,
                            groupAddr: group.addr,
                          );
                        },
                        childCount: group.group.scenes.length,
                      ),
                    ),
                  )
                : SliverToBoxAdapter(
                    child: Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: AddSceneSuggestion(
                      parent: parent,
                    ),
                  )),
            SliverPadding(
              padding: EdgeInsets.only(bottom: 15),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    "Devices",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              ),
            ),
            (group.group.devices.length != 0)
                ? SliverPadding(
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 1.4,
                      ),
                      delegate: SliverChildListDelegate(elementItems),
                    ))
                : SliverToBoxAdapter(
                    child: Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: AddDeviceSuggestion(
                      parent: parent,
                    ),
                  )),
          ],
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage(this.navigatorKey, this.parent);

  final GlobalKey<NavigatorState> navigatorKey;
  final BuildContext parent;
  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        documentNode: gql(availableGroupsQuery),
        variables: {},
      ),
      builder: (QueryResult result,
          {VoidCallback refetch, FetchMore fetchMore}) {
        if (result.hasException) {
          return ConnectError();
        }
        if (result.loading) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
            ),
          );
        }
        List<GroupResponse> groups = (result.data["availableGroups"] as List)
            ?.map((e) => GroupResponse.fromJson(e as Map<String, dynamic>))
            .toList();
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    15,
                    MediaQuery.of(context).padding.top + 15,
                    15,
                    15,
                  ),
                  child: Text(
                    "Home",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(bottom: 15),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    "Groups",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ListItem(
                      text: groups[index].group.name,
                      onTap: () {
                        print(groups[index]);
                        navigatorKey.currentState.push(
                          FadeRoute(
                            builder: (context) =>
                                GroupPage(groups[index], navigatorKey, parent),
                          ),
                        );
                      });
                },
                childCount: groups.length,
              ),
            ),
          ],
        );
      },
    );
  }
}
