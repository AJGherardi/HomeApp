import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/components/items.dart';
import 'package:home/services/store.dart';
import 'package:provider/provider.dart';

String listControl = """
  subscription ListControl {
    listControl {
      devices {
        addr
        elements{ 
          name
          addr
          state
        }
      }
      groups {
        name
        addr
        devAddrs
      }
    }
  }
""";

class ControlPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Subscription(
      "ListControl",
      listControl,
      variables: {
        'webKey': Provider.of<ClientModel>(context).webKey,
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
                Color(0xFFEF323D),
              ),
            ),
          );
        }
        Map<String, Object> listControl =
            payload["listControl"] as Map<String, Object>;
        List groups = listControl["groups"];
        List devices = listControl["devices"];
        return DefaultTabController(
          length: groups.length,
          child: NestedScrollView(
            physics: BouncingScrollPhysics(),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    centerTitle: true,
                    backgroundColor: Colors.grey[50],
                    title: Text(
                      'Control',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    pinned: true,
                    expandedHeight: 100.0,
                    forceElevated: innerBoxIsScrolled,
                    bottom: TabBar(
                      isScrollable: true,
                      indicatorColor: Colors.black,
                      labelColor: Colors.black,
                      tabs: [
                        for (var group in groups) Tab(text: group["name"])
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                for (var group in groups)
                  SafeArea(
                    top: false,
                    bottom: false,
                    child: Builder(
                      builder: (BuildContext context) {
                        // Get DevAddrs
                        List devAddrs = group["devAddrs"];
                        // Get list of devices
                        List groupDevices = new List();
                        for (var devAddr in devAddrs) {
                          var index = devices.indexWhere(
                              (element) => element["addr"] == devAddr);
                          groupDevices.add(devices[index]);
                        }
                        // Get list of elements
                        List groupElements = new List();
                        for (var device in groupDevices) {
                          groupElements.addAll(device["elements"]);
                        }
                        return CustomScrollView(
                          slivers: [
                            SliverOverlapInjector(
                              handle: NestedScrollView
                                  .sliverOverlapAbsorberHandleFor(context),
                            ),
                            SliverPadding(
                              padding: EdgeInsets.all(16),
                              sliver: SliverToBoxAdapter(
                                child: Center(
                                  child: Text(
                                    "Devices",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ),
                              ),
                            ),
                            SliverPadding(
                              padding: EdgeInsets.all(12),
                              sliver: SliverGrid(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  childAspectRatio: 1.4,
                                ),
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    // Check state
                                    String state =
                                        groupElements[index]["state"];
                                    bool isOn;
                                    if (state == "AA==") {
                                      isOn = false;
                                    } else {
                                      isOn = true;
                                    }
                                    return Item(
                                      groupElements[index]["name"],
                                      groupElements[index]["addr"],
                                      isOn,
                                    );
                                  },
                                  childCount: groupElements.length,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
