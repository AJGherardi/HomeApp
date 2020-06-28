import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/components/items.dart';
import 'package:home/components/routes.dart';
import 'package:home/pages/availableDevicesPage.dart';
import 'package:home/services/store.dart';
import 'package:provider/provider.dart';

String listGroups = """
  query ListGroupsQuery {
    listGroups {
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
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(36),
                  child: Text(
                    "Available Groups",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w900,
                      fontSize: 34,
                    ),
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
                          Colors.red[700],
                        ),
                      ),
                    ),
                  );
                }
                List groups = result.data["listGroups"];
                print(Provider.of<ClientModel>(context).webKey);
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return ListItem(
                        groups[index]["name"],
                        () {
                          Navigator.push(
                            context,
                            FadeRoute(
                              builder: (context) => AvailableDevicesPage(),
                            ),
                          );
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
