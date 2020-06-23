import 'package:animations/animations.dart';
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
      home: WelcomePage(),
    );
  }
}

class FadeRoute<T> extends MaterialPageRoute<T> {
  FadeRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }
}

class AddHubPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                "Add Hub",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w900,
                  fontSize: 48,
                  color: Colors.black,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(28, 0, 28, 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(4),
                ),
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
                      margin: EdgeInsets.only(left: 18, right: 18),
                      child: Divider(
                        thickness: 2,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(36),
                      child: Text(
                        "A hub is required",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w900,
                          fontSize: 36,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              NextButton(
                "Add",
                () {
                  Navigator.push(
                    context,
                    FadeRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  NextButton(this.text, this.onPress);
  final String text;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPress,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      color: Colors.black,
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      minWidth: 300,
    );
  }
}

class AvailableHubsPage extends StatelessWidget {
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
                  "Available Hubs",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w900,
                    fontSize: 34,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListItem("Hub", AddHubPage());
              },
              childCount: 22,
            ),
          ),
        ],
      ),
    ));
  }
}

class AddHubSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                "Add Hub",
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w900,
                    fontSize: 48,
                    color: Colors.black),
              ),
              SvgPicture.asset(
                "assets/outlet.svg",
                width: 260,
              ),
              NextButton(
                "Next",
                () {
                  Navigator.push(
                    context,
                    FadeRoute(
                      builder: (context) => AvailableHubsPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Stack(
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Home",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w900,
                        fontSize: 64,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "By",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 30,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Alexander Gherardi",
                      style: GoogleFonts.oleoScript(
                        fontWeight: FontWeight.w400,
                        fontSize: 30,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.all(24),
                  child: NextButton(
                    "Next",
                    () {
                      Navigator.push(
                        context,
                        FadeRoute(
                          builder: (context) => AddHubSplash(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddGroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                "Add Group",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w900,
                  fontSize: 48,
                  color: Colors.black,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(28, 0, 28, 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(12),
                ),
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
                      margin: EdgeInsets.only(left: 18, right: 18),
                      child: Divider(
                        thickness: 2,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(36),
                      child: Text(
                        "A group is a collection of devices",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w900,
                          fontSize: 36,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              NextButton(
                "Add",
                () {
                  showSetNameSheet(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showSetNameSheet(context) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(14),
        topRight: Radius.circular(14),
      ),
    ),
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
                      borderSide:
                          BorderSide(color: Colors.yellow[400], width: 3),
                    ),
                    hintText: "Type name hear",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(16),
                child: NextButton(
                  "Add",
                  () {},
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

class AddDevicePage extends StatelessWidget {
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
                  color: Colors.black,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(28, 0, 28, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black),
                ),
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
                      margin: EdgeInsets.only(left: 18, right: 18),
                      child: Divider(
                        thickness: 2,
                        color: Colors.black,
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
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              NextButton(
                "Add",
                () {
                  showSetNameSheet(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ListItem("Group", AvailableDevicesPage());
                },
                childCount: 22,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AvailableDevicesPage extends StatelessWidget {
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
                    "Available Devices",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w900,
                      fontSize: 34,
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ListItem("Device", AddDevicePage());
                },
                childCount: 22,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  ListItem(this.text, this.page);
  final String text;
  final Widget page;

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
            onTap: () {
              Navigator.push(
                context,
                FadeRoute(builder: (context) => page),
              );
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

class AddGroupSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                "Add a Group",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w900,
                  fontSize: 48,
                  color: Colors.black,
                ),
              ),
              SvgPicture.asset(
                "assets/outlet.svg",
                width: 260,
              ),
              NextButton(
                "Next",
                () {
                  Navigator.push(
                    context,
                    FadeRoute(builder: (context) => AddGroupPage()),
                  );
                },
              ),
            ],
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
                    color: Colors.black),
              ),
              SvgPicture.asset(
                "assets/outlet.svg",
                width: 260,
              ),
              NextButton(
                "Next",
                () {
                  Navigator.push(
                    context,
                    FadeRoute(builder: (context) => AvailableGroupsPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    ControlPage(),
    ActionsPage(),
    ManagePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageTransitionSwitcher(
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: _children[_currentIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.red[700],
          unselectedItemColor: Color(0xBFFFFFFF),
          fixedColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.power_settings_new),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.done_outline),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text(''),
            ),
          ],
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

void showRemoveDialog(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Remove Group"),
        content: Text(
          "Are you sure you want to remove this group",
        ),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.black,
            child: Text("Close"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            textColor: Colors.red[700],
            child: Text("Remove"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
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
                TopIcon(
                  Icons.chevron_left,
                  () {
                    Navigator.pop(context);
                  },
                ),
                TopIcon(
                  Icons.remove_circle_outline,
                  () {
                    showRemoveDialog(context);
                  },
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(12),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SvgPicture.asset(
                    "assets/plug.svg",
                    width: 80,
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
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Living room",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w900,
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ControlItem(),
            ControlItem(),
          ],
        ),
      ),
    );
  }
}

class TopIcon extends StatelessWidget {
  TopIcon(this.icon, this.onPressed);
  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      iconSize: 36,
      color: Colors.black,
      onPressed: onPressed,
    );
  }
}

class ControlItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(12),
        ),
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
                    borderRadius: BorderRadius.circular(6.0),
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
    );
  }
}

class ManagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.all(24),
              child: Text(
                "Manage",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w900,
                  fontSize: 34,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 8, right: 8),
            child: ListItem("Add Device", AddDeviceSplash()),
          ),
          Container(
            margin: EdgeInsets.only(left: 8, right: 8),
            child: ListItem("Add Group", AddGroupSplash()),
          ),
          Container(
            margin: EdgeInsets.only(left: 8, right: 8),
            child: ListItem("Remove Deivce", AddGroupSplash()),
          ),
          Container(
            margin: EdgeInsets.only(left: 8, right: 8),
            child: ListItem("Remove Group", AddGroupSplash()),
          ),
          Container(
            margin: EdgeInsets.only(left: 8, right: 8),
            child: ListItem("Reset", AddGroupSplash()),
          ),
        ],
      ),
    );
  }
}

class ActionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Center(
            child: Container(
              margin: EdgeInsets.all(36),
              child: Text(
                "Actions",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w900,
                  fontSize: 34,
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ListItem("Action", null);
            },
            childCount: 22,
          ),
        )
      ],
    );
  }
}

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
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  Text(
                    "Room",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w900,
                      fontSize: 26,
                    ),
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(12.0),
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 24,
                    crossAxisCount: 2,
                    children: <Widget>[
                      Item("Device", DevicePage()),
                      Item("Device", DevicePage()),
                      Item("Device", DevicePage()),
                      Item("Device", DevicePage()),
                    ],
                  ),
                ],
              );
            },
            childCount: 22,
          ),
        )
      ],
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
        TopIcon(Icons.chevron_left, () {
          Navigator.pop(context);
        }),
        Text(
          text,
          style: GoogleFonts.oleoScript(
            fontSize: 52,
            color: Colors.black,
          ),
        ),
        TopIcon(rightIcon, onPress)
      ],
    );
  }
}

class Item extends StatelessWidget {
  Item(this.text, this.page);
  final String text;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(4),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.black),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap: () {
            Navigator.push(
              context,
              FadeRoute(builder: (context) => page),
            );
          },
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SvgPicture.asset(
                  "assets/plug.svg",
                  width: 100,
                ),
                Text(
                  text,
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
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
