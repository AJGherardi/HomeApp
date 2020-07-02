import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/components/items.dart';
import 'package:home/pages/devicePage.dart';
import 'package:home/services/store.dart';
import 'package:provider/provider.dart';

String listGroups = """
  query ListGroups {
    listGroups {
      name
      addr
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
        // Query(
        //   options: QueryOptions(
        //     documentNode: gql(listGroups),
        //     variables: {
        //       'webKey': Provider.of<ClientModel>(context).webKey,
        //     },
        //   ),
        //   builder: (QueryResult result,
        //       {VoidCallback refetch, FetchMore fetchMore}) {
        //     if (result.loading) {
        //       return SliverFillRemaining(
        //         hasScrollBody: false,
        //         child: Center(
        //           child: CircularProgressIndicator(
        //             valueColor: AlwaysStoppedAnimation<Color>(
        //               Color(0xFFEF323D),
        //             ),
        //           ),
        //         ),
        //       );
        //     }
        //     List groups = result.data["listGroups"];
        //     print(Provider.of<ClientModel>(context).webKey);
        //     return SliverList(
        //       delegate: SliverChildBuilderDelegate(
        //         (BuildContext context, int index) {
        //           print(groups[index]);
        //           // List devices = groups[index]["devices"];
        //           return Column(
        //             children: <Widget>[
        //               Text(
        //                 groups[index]["name"],
        //                 style: GoogleFonts.roboto(
        //                   fontWeight: FontWeight.w900,
        //                   fontSize: 26,
        //                 ),
        //               ),
        //               GridView.builder(
        //                 shrinkWrap: true,
        //                 physics: BouncingScrollPhysics(),
        //                 padding: EdgeInsets.all(12.0),
        //                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //                   crossAxisCount: 2,
        //                   crossAxisSpacing: 24,
        //                   mainAxisSpacing: 24,
        //                 ),
        //                 // itemCount: devices.length,
        //                 itemBuilder: (BuildContext context, int index) {
        //                   return Item(
        //                     "device",
        //                     DevicePage(),
        //                   );
        //                 },
        //               ),
        //             ],
        //           );
        //         },
        //         childCount: groups.length,
        //       ),
        //     );
        //   },
        // ),
      ],
    );
  }
}
