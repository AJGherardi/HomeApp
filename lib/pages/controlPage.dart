import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          state { state }
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
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Center(
            child: Container(
              margin: EdgeInsets.all(36),
              child: Text(
                "Control",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w900,
                  fontSize: 34,
                ),
              ),
            ),
          ),
        ),
        Subscription(
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
            Map<String, Object> listControl =
                payload["listControl"] as Map<String, Object>;
            List groups = listControl["groups"];
            List devices = listControl["devices"];
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  // Get DevAddrs
                  List devAddrs = groups[index]["devAddrs"];
                  // Get list of devices
                  List groupDevices = new List();
                  for (var devAddr in devAddrs) {
                    var index = devices
                        .indexWhere((element) => element["addr"] == devAddr);
                    groupDevices.add(devices[index]);
                  }
                  // Get list of elements
                  List groupElements = new List();
                  for (var device in groupDevices) {
                    groupElements.addAll(device["elements"]);
                  }
                  return Column(
                    children: <Widget>[
                      Text(
                        groups[index]["name"],
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w900,
                          fontSize: 26,
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.all(12.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 24,
                          childAspectRatio: 1.3,
                        ),
                        itemCount: groupElements.length,
                        itemBuilder: (BuildContext context, int index) {
                          // Check state
                          String state = groupElements[index]["state"]["state"];
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
                      ),
                    ],
                  );
                },
                childCount: groups.length,
              ),
            );
          },
        ),
      ],
    );
  }
}
