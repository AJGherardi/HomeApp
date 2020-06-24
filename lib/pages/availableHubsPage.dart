import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/components/items.dart';
import 'package:home/pages/addHubPage.dart';
import 'package:multicast_dns/multicast_dns.dart';

Stream<List<SrvResourceRecord>> find() async* {
  var factory =
      (dynamic host, int port, {bool reuseAddress, bool reusePort, int ttl}) {
    return RawDatagramSocket.bind(host, port,
        reuseAddress: true, reusePort: false, ttl: 1);
  };
  List<SrvResourceRecord> services = [];
  const String name = '_alexandergherardi._tcp.local';
  var client = MDnsClient(rawDatagramSocketFactory: factory);
  await client.start();
  await for (PtrResourceRecord ptr in client
      .lookup<PtrResourceRecord>(ResourceRecordQuery.serverPointer(name))) {
    await for (SrvResourceRecord srv in client.lookup<SrvResourceRecord>(
        ResourceRecordQuery.service(ptr.domainName))) {
      if (srv != null) {
        services.add(srv);
        yield services;
      }
    }
  }
  client.stop();
  print("done");
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
            StreamBuilder(
              builder:
                  (context, AsyncSnapshot<List<SrvResourceRecord>> snapshot) {
                if (snapshot.hasData) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return ListItem(
                          snapshot.data.elementAt(index).target,
                          AddHubPage(
                            host: snapshot.data.elementAt(index).target,
                          ),
                        );
                      },
                      childCount: snapshot.data.length,
                    ),
                  );
                } else {
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
              },
              stream: find(),
            ),
          ],
        ),
      ),
    );
  }
}
