import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/components/items.dart';
import 'package:home/pages/addDevicePage.dart';
import 'package:home/services/store.dart';
import 'package:provider/provider.dart';

String listGroups = """
  query AvailableGroups {
    availableGroups {
      name
      addr
    }
  }
""";

class AvailableGroupsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(15),
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
                variables: {
                  'webKey': Provider.of<ClientModel>(context).webKey,
                },
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
                      return ListItem(
                        groups[index]["name"],
                        () {
                          Provider.of<AddDeviceModel>(context, listen: false)
                              .groupAddr = groups[index]["addr"];
                        },
                      );
                    },
                    childCount: groups.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
