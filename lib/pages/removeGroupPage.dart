import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/components/switcher.dart';
import 'package:home/graphql/graphql.dart';
import 'package:home/pages/availableGroupsPage.dart';
import 'package:home/services/graphql.dart';
import 'package:provider/provider.dart';

class RemoveGroupModel {
  num groupAddr;
}

class RemoveGroupPage extends StatefulWidget {
  @override
  _RemoveGroupPageState createState() => _RemoveGroupPageState();
}

class _RemoveGroupPageState extends State<RemoveGroupPage> {
  final List<Widget> _children = [
    AvailableGroupsPage(
      onSelected: (context, addr) {
        Provider.of<RemoveGroupModel>(context, listen: false).groupAddr = addr;
      },
      checkSelected: (context, addr) {
        return Provider.of<RemoveGroupModel>(context, listen: false)
                .groupAddr ==
            addr;
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Provider<RemoveGroupModel>(
      create: (_) {
        var model = RemoveGroupModel();
        model.groupAddr = 0;
        return model;
      },
      builder: (context, _) {
        return PageSwitcher(
          children: _children,
          doneButton: MutationWithBuilder(
            onCompleted: (resultData) {
              // Get name and addr from result
              var data = resultData["removeGroup"];
            },
            query: removeGroupMutation,
            builder: (
              RunMutation runMutation,
              QueryResult result,
            ) {
              return Container(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: () {
                    runMutation({
                      'groupAddr':
                          Provider.of<RemoveGroupModel>(context, listen: false)
                              .groupAddr,
                    });
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: EdgeInsets.all(12),
                    child: Text(
                      "Done",
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
