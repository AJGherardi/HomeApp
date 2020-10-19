import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/components/bars.dart';
import 'package:home/components/dialogs.dart';
import 'package:home/components/items.dart';
import 'package:home/components/routes.dart';

String listGroup = """
  subscription ListGroup(\$addr: String!) {
    listGroup(addr: \$addr) {
      devices {
        addr
        elements{ 
          name
          addr
          stateType
        }
      }
      scenes {
        name
        number
      }
    }
  }
""";

String listGroups = """
  query AvailableGroups {
    availableGroups {
      name
      addr
    }
  }
""";

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

  final Map<String, Object> group;
  final GlobalKey<NavigatorState> navigatorKey;
  final BuildContext parent;
  @override
  Widget build(BuildContext context) {
    return Subscription(
      "ListGroup",
      listGroup,
      variables: {
        'addr': group["addr"],
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
                    text: group["name"],
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
            (scenes.length != 0)
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
                            name: scenes[index]["name"],
                            number: scenes[index]["number"],
                            addr: group["addr"],
                          );
                        },
                        childCount: scenes.length,
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
            (devices.length != 0)
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
                          if (groupElements[index]["stateType"] == "onoff") {
                            return OnoffItem(
                              name: groupElements[index]["name"],
                              addr: groupElements[index]["addr"],
                            );
                          }
                          if (groupElements[index]["stateType"] == "event") {
                            return EventItem(
                              name: groupElements[index]["name"],
                              addr: groupElements[index]["addr"],
                              groupAddr: group["addr"],
                            );
                          }
                          return Container();
                        },
                        childCount: groupElements.length,
                      ),
                    ),
                  )
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
        documentNode: gql(listGroups),
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
        List groups = result.data["availableGroups"];
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
                      text: groups[index]["name"],
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
