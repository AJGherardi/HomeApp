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
        return PageView.builder(
          itemCount: groups.length,
          itemBuilder: (BuildContext context, int index) {
            // Get DevAddrs
            List devAddrs = groups[index]["devAddrs"];
            // Get list of devices
            List groupDevices = new List();
            for (var devAddr in devAddrs) {
              var index =
                  devices.indexWhere((element) => element["addr"] == devAddr);
              groupDevices.add(devices[index]);
            }
            // Get list of elements
            List groupElements = new List();
            for (var device in groupDevices) {
              groupElements.addAll(device["elements"]);
            }
            return CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 100.0,
                  backgroundColor: Colors.grey[50],
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                      groups[index]["name"],
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      "Devices",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(12,16,12, 0),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.4,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        // Check state
                        String state = groupElements[index]["state"];
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
                )
              ],
            );
          },
        );
      },
    );
  }
}
