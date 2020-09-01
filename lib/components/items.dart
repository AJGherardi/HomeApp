import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/services/graphql.dart';
import 'package:home/services/store.dart';
import 'package:provider/provider.dart';

String getState = """
  query GetState(\$devAddr: String!, \$elemNumber: Int!) {
    getState(devAddr: \$devAddr, elemNumber: \$elemNumber) {
      state
      stateType
    }
  }
""";

String setState = """
  mutation SetState(\$addr: String!, \$value: String!) {
    setState(addr: \$addr, value: \$value)
  }
""";

class Item extends StatelessWidget {
  Item(this.name, this.addr, this.isOn);
  final String name;
  final String addr;
  final bool isOn;

  @override
  Widget build(BuildContext context) {
    return MutationWithBuilder(
      onCompleted: (resultData) {},
      query: setState,
      builder: (
        RunMutation runMutation,
        QueryResult result,
      ) {
        return Material(
          borderRadius: BorderRadius.circular(6),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.black),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(6),
              onTap: () {
                runMutation({
                  'webKey':
                      Provider.of<ClientModel>(context, listen: false).webKey,
                  'addr': addr,
                  'value': isOn ? "AA==" : "AQ==",
                });
              },
              onLongPress: () {},
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
                      name,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      isOn ? "On" : "Off",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
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
        borderRadius: BorderRadius.circular(6),
        child: Ink(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
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
