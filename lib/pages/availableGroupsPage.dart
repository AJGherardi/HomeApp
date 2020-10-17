import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/components/items.dart';
import 'package:home/components/title.dart';
import 'package:home/pages/addDevicePage.dart';
import 'package:provider/provider.dart';

String listGroups = """
  query AvailableGroups {
    availableGroups {
      name
      addr
    }
  }
""";

typedef bool CheckSelected(context, String addr);
typedef void OnSelected(context, String addr);

class AvailableGroupsPage extends StatefulWidget {
  AvailableGroupsPage({
    @required this.checkSelected,
    @required this.onSelected,
  });
  final CheckSelected checkSelected;
  final OnSelected onSelected;

  @override
  _AvailableGroupsPageState createState() => _AvailableGroupsPageState();
}

class _AvailableGroupsPageState extends State<AvailableGroupsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Center(
              child: TitleText(text: "Available Groups"),
            ),
          ),
          Query(
            options: QueryOptions(
              documentNode: gql(listGroups),
              variables: {},
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
              List groups = result.data["availableGroups"];
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return SelectableListItem(
                      text: groups[index]["name"],
                      onTap: () {
                        // Provider.of<AddDeviceModel>(context, listen: false)
                        //     .groupAddr = groups[index]["addr"];
                        widget.onSelected(context, groups[index]["addr"]);
                        setState(() {});
                      },
                      selected:
                          widget.checkSelected(context, groups[index]["addr"]),
                    );
                    // (Provider.of<AddDeviceModel>(context, listen: false)
                    //             .groupAddr ==
                    //         groups[index]["addr"])
                    //     ? true
                    //     : false);
                  },
                  childCount: groups.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
