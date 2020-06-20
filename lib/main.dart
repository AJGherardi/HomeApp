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
        '/Group': (context) => GroupPage(),
        '/Device': (context) => DevicePage(),
        '/AddDeviceSplash': (context) => AddDeviceSplash(),
        '/AvailableDevices': (context) => AvailableDevices(),
        '/AvailableGroups': (context) => AvailableGroups(),
        '/AddDevice': (context) => AddDevice(),
      },
    );
  }
}

class AddDevice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                "Add Device",
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w900,
                    fontSize: 48,
                    color: Colors.white),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(28, 0, 28, 0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(36),
                      child: SvgPicture.asset(
                        "assets/range.svg",
                        width: 250,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(36),
                      child: Text(
                        "This may take a minute",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w900,
                            fontSize: 36,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () {
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(14),
                            topRight: Radius.circular(14))),
                    context: context,
                    builder: (BuildContext bc) {
                      return AnimatedPadding(
                        padding: MediaQuery.of(context).viewInsets,
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.decelerate,
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(16),
                                child: Text(
                                  "Set Name",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 36,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(16),
                                child: TextField(
                                  cursorColor: Colors.yellow[400],
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.yellow[400], width: 3),
                                    ),
                                    hintText: "Type name hear",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(16),
                                child: MaterialButton(
                                  onPressed: () {},
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  color: Colors.black,
                                  child: Text(
                                    'Add',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  minWidth: 300,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.white,
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.black),
                ),
                minWidth: 250,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AvailableGroups extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(18),
                child: Text(
                  "Available Groups",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w900,
                      fontSize: 48,
                      color: Colors.white),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(24.0),
                  itemCount: 12,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return new ListItem("Group", "/AvailableDevices");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AvailableDevices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(14),
                child: Text(
                  "Available Devices",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w900,
                      fontSize: 48,
                      color: Colors.white),
                ),
              ),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(24.0),
                  itemCount: 12,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return new ListItem("Device", "/AddDevice");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  ListItem(this.text, this.route);
  final String text;
  final String route;

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.all(8),
      child: Material(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              Navigator.pushNamed(context, route);
            },
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    text,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                      color: Colors.white,
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

class AddDeviceSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                "Add a Device",
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w900,
                    fontSize: 48,
                    color: Colors.white),
              ),
              SvgPicture.asset(
                "assets/outlet.svg",
                width: 260,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/AvailableGroups");
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.white,
                child: Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                minWidth: 260,
              )
            ],
          ),
        ),
      ),
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
          bottomNavigationBar: BottomBar()),
    );
  }
}

class DevicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.chevron_left),
                  iconSize: 36,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.remove_circle_outline),
                  iconSize: 36,
                  color: Colors.white,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: new Text("Remove Group"),
                          content: new Text(
                              "Are you sure you want to remove this group"),
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
                  },
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SvgPicture.asset(
                  "assets/plug.svg",
                  width: 120,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Left outlet",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w900,
                        fontSize: 32,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Living room",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w900,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            new Flexible(
              child: Container(
                margin: EdgeInsets.fromLTRB(24, 36, 24, 12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SvgPicture.asset(
                        "assets/power.svg",
                        width: 120,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "State",
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w900,
                              fontSize: 36,
                              color: Colors.black,
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: Colors.black,
                            child: Text(
                              'Off',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            new Flexible(
              child: Container(
                margin: EdgeInsets.fromLTRB(24, 12, 24, 36),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SvgPicture.asset(
                        "assets/power.svg",
                        width: 120,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "State",
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w900,
                              fontSize: 36,
                              color: Colors.black,
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: Colors.black,
                            child: Text(
                              'Off',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            TopBar("Group Name", Icons.remove_circle_outline, () {}),
            Flexible(
              child: GridView.count(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(24.0),
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                crossAxisCount: 2,
                children: <Widget>[
                  Item("Device", "/Device"),
                  Item("Device", "/Device"),
                  Item("Device", "/Device"),
                  Item("Device", "/Device"),
                  Item("Device", "/Device"),
                  Item("Device", "/Device"),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}

class DevicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            TopBar(
              "Devices",
              Icons.add,
              () {
                Navigator.pushNamed(context, "/AddDeviceSplash");
              },
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
                  Item("Device", "/Device"),
                  Item("Device", "/Device"),
                  Item("Device", "/Device"),
                  Item("Device", "/Device"),
                  Item("Device", "/Device"),
                  Item("Device", "/Device"),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}

class GroupsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            TopBar("Groups", Icons.add, () {}),
            Flexible(
              child: GridView.count(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(24.0),
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                crossAxisCount: 2,
                children: <Widget>[
                  Item("Group", "/Group"),
                  Item("Group", "/Group"),
                  Item("Group", "/Group"),
                  Item("Group", "/Group"),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  TopBar(this.text, this.rightIcon, this.onPress);
  final String text;
  final IconData rightIcon;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.chevron_left),
          iconSize: 36,
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        Text(
          text,
          style: GoogleFonts.oleoScript(fontSize: 52, color: Colors.white),
        ),
        IconButton(
          icon: Icon(rightIcon),
          iconSize: 36,
          color: Colors.white,
          onPressed: onPress,
        )
      ],
    );
  }
}

class Item extends StatelessWidget {
  Item(this.text, this.route);
  final String text;
  final String route;

  @override
  Widget build(BuildContext context) {
    return new Material(
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
            ),
          ),
        ),
      ),
    );
  }
}

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
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
                },
              );
            },
          ),
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
                          onTap: () => {
                            Navigator.pushNamed(context, "/AddDeviceSplash")
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
