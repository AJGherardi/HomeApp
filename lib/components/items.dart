import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home/components/dialogs.dart';
import 'package:home/graphql/graphql.dart';
import 'package:home/graphql/types.dart';
import 'package:home/pages/removeDevicePage.dart';
import 'package:home/services/graphql.dart';
import 'package:home/components/sheets.dart';
import 'package:provider/provider.dart';

class Card extends StatelessWidget {
  Card({
    this.onLongPress,
    @required this.onTap,
    @required this.children,
  });
  final Function onTap;
  final Function onLongPress;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
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
          onTap: onTap,
          onLongPress: onLongPress,
          child: Container(
            margin: EdgeInsets.all(12),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children),
          ),
        ),
      ),
    );
  }
}

class SelectSceneItem extends StatefulWidget {
  SelectSceneItem({
    @required this.name,
    @required this.number,
    @required this.groupAddr,
    @required this.devAddr,
    @required this.elemAddr,
  });
  final String name;
  final num number;
  final num groupAddr;
  final num devAddr;
  final num elemAddr;

  @override
  _SelectSceneItemState createState() => _SelectSceneItemState();
}

class _SelectSceneItemState extends State<SelectSceneItem> {
  @override
  Widget build(BuildContext context) {
    return MutationWithBuilder(
      onCompleted: (resultData) {},
      query: eventBindMutation,
      builder: (
        RunMutation runMutation,
        QueryResult result,
      ) {
        return Card(
          onTap: () {
            runMutation(
              {
                'sceneNumber': widget.number,
                'groupAddr': widget.groupAddr,
                'devAddr': widget.devAddr,
                'elemAddr': widget.elemAddr
              },
            );
            Navigator.pop(context);
          },
          onLongPress: () {},
          children: <Widget>[
            SvgPicture.asset(
              "assets/scene.svg",
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
          ],
        );
      },
    );
  }
}

class SceneItem extends StatefulWidget {
  SceneItem({
    @required this.name,
    @required this.number,
    @required this.groupAddr,
  });
  final String name;
  final num number;
  final num groupAddr;

  @override
  _SceneItemState createState() => _SceneItemState();
}

class _SceneItemState extends State<SceneItem> {
  @override
  Widget build(BuildContext context) {
    return MutationWithBuilder(
      onCompleted: (resultData) {},
      query: sceneRecallMutation,
      builder: (
        RunMutation runMutation,
        QueryResult result,
      ) {
        return Card(
          onTap: () {
            runMutation(
              {'sceneNumber': widget.number, 'groupAddr': widget.groupAddr},
            );
          },
          onLongPress: () {
            showSceneSheet(
                context, widget.name, widget.groupAddr, widget.number);
          },
          children: <Widget>[
            SvgPicture.asset(
              "assets/scene.svg",
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
          ],
        );
      },
    );
  }
}

class ListItem extends StatelessWidget {
  ListItem({
    @required this.text,
    @required this.onTap,
  });
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

class EventItem extends StatefulWidget {
  EventItem({
    @required this.name,
    @required this.groupAddr,
    @required this.devAddr,
    @required this.elemAddr,
  });
  final String name;
  final num groupAddr;
  final num devAddr;
  final num elemAddr;

  @override
  _EventItemState createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      onTap: () {
        showEventSheet(context, widget.name, widget.groupAddr, widget.devAddr,
            widget.elemAddr);
      },
      onLongPress: () {},
      children: <Widget>[
        SvgPicture.asset(
          "assets/button.svg",
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
      ],
    );
  }
}

class OnoffItem extends StatefulWidget {
  OnoffItem({
    @required this.name,
    @required this.groupAddr,
    @required this.devAddr,
    @required this.elemAddr,
  });
  final String name;
  final num groupAddr;
  final num devAddr;
  final num elemAddr;

  @override
  _OnoffItemState createState() => _OnoffItemState();
}

class _OnoffItemState extends State<OnoffItem> {
  String state = "AA==";

  @override
  Widget build(BuildContext context) {
    return MutationWithBuilder(
      onCompleted: (resultData) {},
      query: setStateMutation,
      builder: (
        RunMutation runMutation,
        QueryResult result,
      ) {
        return Card(
          onTap: () {
            String newState;
            if (state == "AA==") {
              newState = "AQ==";
            } else {
              newState = "AA==";
            }
            runMutation({
              'groupAddr': widget.groupAddr,
              'elemAddr': widget.elemAddr,
              'value': newState
            });
          },
          onLongPress: () {},
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
            Subscription("WatchState", watchStateSubscription, variables: {
              'groupAddr': widget.groupAddr,
              'devAddr': widget.devAddr,
              'elemAddr': widget.elemAddr,
            }, builder: ({
              bool loading,
              dynamic payload,
              dynamic error,
            }) {
              if (error != null) {
                return ConnectError();
              }
              if (loading) {
                return Text(
                  "-",
                  style: Theme.of(context).textTheme.bodyText2,
                );
              }
              state = payload["watchState"];
              return state == "AA=="
                  ? Text(
                      "Off",
                      style: Theme.of(context).textTheme.bodyText2,
                    )
                  : Text(
                      "On",
                      style: Theme.of(context).textTheme.bodyText2,
                    );
            }),
          ],
        );
      },
    );
  }
}

class SelectableListItem extends StatelessWidget {
  SelectableListItem({
    @required this.text,
    @required this.onTap,
    @required this.selected,
  });
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

class SelectDeviceItem extends StatefulWidget {
  SelectDeviceItem({
    @required this.device,
  });
  final DeviceResponse device;

  @override
  _SelectDeviceItemState createState() => _SelectDeviceItemState();
}

class _SelectDeviceItemState extends State<SelectDeviceItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      onTap: () {
        Provider.of<RemoveDeviceModel>(context, listen: false).devAddr =
            widget.device.addr;
        setState(() {});
      },
      onLongPress: () {},
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              "assets/plug.svg",
              color: Theme.of(context).primaryColor,
              width: 35,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              // child: ,

              child: Visibility(
                child: Icon(Icons.check),
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: (Provider.of<RemoveDeviceModel>(context, listen: false)
                        .devAddr ==
                    widget.device.addr),
              ),
            )
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (var element in widget.device.device.elements)
              Text(
                element.element.name,
                style: Theme.of(context).textTheme.bodyText1,
              ),
          ],
        )
      ],
    );
  }
}
