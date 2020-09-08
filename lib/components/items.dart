import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/services/graphql.dart';
import 'package:home/services/store.dart';
import 'package:provider/provider.dart';
import 'package:home/components/sheets.dart';

String _getState = """
  subscription GetState(\$addr: String!) {
    getState(addr: \$addr)
  }
""";

String _setState = """
  mutation SetState(\$addr: String!, \$value: String!) {
    setState(addr: \$addr, value: \$value)
  }
""";

class Item extends StatefulWidget {
  Item(this.name, this.addr);
  final String name;
  final String addr;

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  String state = "AA==";

  @override
  Widget build(BuildContext context) {
    return MutationWithBuilder(
      onCompleted: (resultData) {},
      query: _setState,
      builder: (
        RunMutation runMutation,
        QueryResult result,
      ) {
        return Material(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(6),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: (Theme.of(context).brightness != Brightness.dark)
                  ? Border.all(color: Colors.black)
                  : Border.all(width: 0),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(6),
              onTap: () {
                String newState;
                if (state == "AA==") {
                  newState = "AQ==";
                } else {
                  newState = "AA==";
                }
                runMutation({
                  'webKey':
                      Provider.of<ClientModel>(context, listen: false).webKey,
                  'addr': widget.addr,
                  'value': newState
                });
              },
              onLongPress: () {
                showDeviceSheet(context, widget.name);
              },
              child: Container(
                margin: EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SvgPicture.asset(
                      "assets/plug.svg",
                      color: Theme.of(context).primaryColor,
                      width: 35,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      widget.name,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Subscription("GetState", _getState, variables: {
                      'webKey': Provider.of<ClientModel>(context).webKey,
                      'addr': widget.addr,
                    }, builder: ({
                      bool loading,
                      dynamic payload,
                      dynamic error,
                    }) {
                      if (loading) {
                        return Text(
                          "-",
                          style: Theme.of(context).textTheme.bodyText2,
                        );
                      }
                      state = payload["getState"];
                      if (state == "AA==") {
                        return Text(
                          "Off",
                          style: Theme.of(context).textTheme.bodyText2,
                        );
                      } else {
                        return Text(
                          "On",
                          style: Theme.of(context).textTheme.bodyText2,
                        );
                      }
                    }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ListItem extends StatelessWidget {
  ListItem(this.text, this.onTap);
  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(6),
        child: Ink(
          decoration: BoxDecoration(
            border: (Theme.of(context).brightness != Brightness.dark)
                ? Border.all(color: Colors.black)
                : Border.all(width: 0),
            borderRadius: BorderRadius.circular(6),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(6),
            onTap: onTap,
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    text,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SelectableListItem extends StatelessWidget {
  SelectableListItem(this.text, this.onTap, this.selected);
  final String text;
  final bool selected;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(6),
        child: Ink(
          decoration: BoxDecoration(
            border: (Theme.of(context).brightness != Brightness.dark)
                ? Border.all(color: Colors.black)
                : Border.all(width: 0),
            borderRadius: BorderRadius.circular(6),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(6),
            onTap: onTap,
            child: Container(
              margin: EdgeInsets.all(10),
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 24),
                    child: AnimatedCrossFade(
                      firstChild: Icon(
                        Icons.check,
                        size: 28,
                      ),
                      secondChild: Icon(
                        Icons.check,
                        color: Colors.transparent,
                      ),
                      crossFadeState: (selected)
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: Duration(milliseconds: 150),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      text,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
