import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/components/items.dart';
import 'package:home/pages/addScenePage.dart';
import 'package:home/pages/availableGroupsPage.dart';
import 'package:provider/provider.dart';

class SelectGroupPage extends StatefulWidget {
  @override
  _SelectGroupPageState createState() => _SelectGroupPageState();
}

class _SelectGroupPageState extends State<SelectGroupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(
                  15,
                  MediaQuery.of(context).padding.top + 15,
                  15,
                  15,
                ),
                child: Text(
                  "Available Groups",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
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
                    return SelectableListItem(groups[index]["name"], () {
                      Provider.of<AddSceneModel>(context, listen: false)
                          .groupAddr = groups[index]["addr"];
                      setState(() {});
                    },
                        (Provider.of<AddSceneModel>(context, listen: false)
                                    .groupAddr ==
                                groups[index]["addr"])
                            ? true
                            : false);
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
