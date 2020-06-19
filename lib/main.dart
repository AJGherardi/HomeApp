import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.black),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/Devices': (context) => DevicesPage(),
        '/Groups': (context) => GroupsPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
              child: Container(
            margin: EdgeInsets.all(24),
            child: Column(
              children: <Widget>[
                HomeItem("Devices", "/Devices"),
                new SizedBox(
                  height: 24,
                ),
                HomeItem("Groups", "/Groups"),
                new SizedBox(
                  height: 24,
                ),
                HomeItem("Actions", "/Devices")
              ],
            ),
          )),
          bottomNavigationBar: HomeAppBar()),
    );
  }
}

class DevicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.chevron_left),
                      iconSize: 36,
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  Text(
                    "Devices",
                    style: GoogleFonts.oleoScript(
                        fontSize: 52, color: Colors.white),
                  ),
                  IconButton(
                      icon: Icon(Icons.add),
                      iconSize: 36,
                      color: Colors.white,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: new Text("Remove Device"),
                              content: new Text(
                                  "Are you sure you want to remove this device"),
                              actions: <Widget>[
                                new FlatButton(
                                  textColor: Colors.black,
                                  child: new Text("Close"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                new FlatButton(
                                  textColor: Colors.red[700],
                                  child: new Text("Remove"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }),
                ],
              ),
              Flexible(
                child: GridView.count(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(24.0),
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 24,
                  crossAxisCount: 2,
                  children: <Widget>[
                    Item("Device", "/"),
                    Item("Device", "/"),
                    Item("Device", "/"),
                    Item("Device", "/"),
                    Item("Device", "/"),
                    Item("Device", "/"),
                    Item("Device", "/"),
                    Item("Device", "/"),
                    Item("Device", "/"),
                    Item("Device", "/"),
                    Item("Device", "/"),
                    Item("Device", "/"),
                    Item("Device", "/"),
                    Item("Device", "/"),
                  ],
                ),
              ),
            ]),
            bottomNavigationBar: HomeAppBar()));
  }
}

class GroupsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.chevron_left),
                      iconSize: 36,
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  Text(
                    "Groups",
                    style: GoogleFonts.oleoScript(
                        fontSize: 52, color: Colors.white),
                  ),
                  IconButton(
                      icon: Icon(Icons.add),
                      iconSize: 36,
                      color: Colors.white,
                      onPressed: () {}),
                ],
              ),
              Flexible(
                child: GridView.count(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(24.0),
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 24,
                  crossAxisCount: 2,
                  children: <Widget>[
                    Item("Groups", "/"),
                    Item("Groups", "/"),
                    Item("Groups", "/"),
                    Item("Groups", "/"),
                    Item("Groups", "/"),
                    Item("Groups", "/"),
                    Item("Groups", "/"),
                    Item("Groups", "/"),
                    Item("Groups", "/"),
                    Item("Groups", "/"),
                    Item("Groups", "/"),
                    Item("Groups", "/"),
                    Item("Groups", "/"),
                    Item("Groups", "/"),
                  ],
                ),
              ),
            ]),
            bottomNavigationBar: HomeAppBar()));
  }
}

class Item extends StatelessWidget {
  Item(this.text, this.route);
  final String text;
  final String route;

  @override
  Widget build(BuildContext context) {
    return new Flexible(
      child: new Material(
        borderRadius: BorderRadius.circular(10),
        child: Ink(
            child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            Navigator.pushNamed(context, route);
          },
          child: Center(
              child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SvgPicture.asset(
                "assets/plug.svg",
                width: 120,
              ),
              Text(
                text,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                ),
              ),
            ],
          )),
        )),
      ),
    );
  }
}

class HomeAppBar extends StatefulWidget {
  @override
  _HomeAppBarState createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return new BottomAppBar(
      color: Colors.red[700],
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
              color: Colors.white,
              icon: Icon(Icons.menu),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext bc) {
                      return Container(
                        child: new Wrap(
                          children: <Widget>[
                            new ListTile(
                              leading: new Icon(Icons.remove_circle_outline),
                              title: new Text('Reset'),
                              onTap: () => {},
                            ),
                          ],
                        ),
                      );
                    });
              }),
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext bc) {
                    return Container(
                      child: new Wrap(
                        children: <Widget>[
                          new ListTile(
                              leading: new Icon(Icons.group_work),
                              title: new Text('Group'),
                              onTap: () => {}),
                          new ListTile(
                            leading: new Icon(Icons.add_circle),
                            title: new Text('Device'),
                            onTap: () => {},
                          ),
                        ],
                      ),
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}

class HomeItem extends StatelessWidget {
  HomeItem(this.text, this.route);
  final String text;
  final String route;

  @override
  Widget build(BuildContext context) {
    return new Flexible(
      child: new Material(
        borderRadius: BorderRadius.circular(18),
        child: Ink(
            child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {
            Navigator.pushNamed(context, route);
          },
          child: Center(
              child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                text,
                style: GoogleFonts.oleoScript(
                  fontSize: 48,
                ),
              ),
              SvgPicture.asset(
                "assets/plug.svg",
                width: 150,
              ),
            ],
          )),
        )),
      ),
    );
  }
}
