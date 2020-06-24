import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/components/items.dart';
import 'package:home/pages/addHubPage.dart';
import 'package:multicast_dns/multicast_dns.dart';

void find(Function(SrvResourceRecord service) add) async {
  var factory =
      (dynamic host, int port, {bool reuseAddress, bool reusePort, int ttl}) {
    return RawDatagramSocket.bind(host, port,
        reuseAddress: true, reusePort: false, ttl: 1);
  };
  const String name = '_alexandergherardi._tcp.local';
  var client = MDnsClient(rawDatagramSocketFactory: factory);
  await client.start();
  await for (PtrResourceRecord ptr in client
      .lookup<PtrResourceRecord>(ResourceRecordQuery.serverPointer(name))) {
    await for (SrvResourceRecord srv in client.lookup<SrvResourceRecord>(
        ResourceRecordQuery.service(ptr.domainName))) {
      if (srv != null) {
        add(srv);
      }
    }
  }
  client.stop();
}

class AvailableHubsPage extends StatefulWidget {
  @override
  _AvailableHubsPageState createState() => _AvailableHubsPageState();
}

class _AvailableHubsPageState extends State<AvailableHubsPage> {
  List<SrvResourceRecord> services = [];

  @override
  Widget build(BuildContext context) {
    find((service) {
      setState(() {
        services.add(service);
      });
    });
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
                  return ListItem(
                    services.elementAt(index).name,
                    AddHubPage(),
                  );
                },
                childCount: services.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
