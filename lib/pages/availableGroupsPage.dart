import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/components/dialogs.dart';
import 'package:home/components/items.dart';
import 'package:home/components/title.dart';
import 'package:home/graphql/graphql.dart';
import 'package:home/graphql/types.dart';

typedef bool CheckSelected(context, num addr);
typedef void OnSelected(context, num addr);

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
              documentNode: gql(availableGroupsQuery),
              variables: {},
            ),
            builder: (QueryResult result,
                {VoidCallback refetch, FetchMore fetchMore}) {
              if (result.hasException) {
                return SliverFillRemaining(child: ConnectError());
              }
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
              List<GroupResponse> groups = (result.data["availableGroups"]
                      as List)
                  ?.map(
                      (e) => GroupResponse.fromJson(e as Map<String, dynamic>))
                  .toList();
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return SelectableListItem(
                      text: groups[index].group.name,
                      onTap: () {
                        widget.onSelected(context, groups[index].addr);
                        setState(() {});
                      },
                      selected:
                          widget.checkSelected(context, groups[index].addr),
                    );
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
