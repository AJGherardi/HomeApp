import 'dart:io';
import 'package:flutter/material.dart';
import 'package:home/components/items.dart';
import 'package:home/pages/onboardingPage.dart';
import 'package:home/services/store.dart';
import 'package:multicast_dns/multicast_dns.dart';
import 'package:provider/provider.dart';

class Record {
  String address;
  bool provisioned;
}

Stream<List<Record>> find() async* {
  var factory =
      (dynamic host, int port, {bool reuseAddress, bool reusePort, int ttl}) {
    return RawDatagramSocket.bind(host, port,
        reuseAddress: true, reusePort: false, ttl: 1);
  };
  List<Record> records = [];
  const String name = '_alexandergherardi._tcp.local';
  var client = MDnsClient(rawDatagramSocketFactory: factory);
  await client.start();
  await for (PtrResourceRecord ptr in client
      .lookup<PtrResourceRecord>(ResourceRecordQuery.serverPointer(name))) {
    await for (SrvResourceRecord srv in client.lookup<SrvResourceRecord>(
        ResourceRecordQuery.service(ptr.domainName))) {
      if (srv != null) {
        await for (IPAddressResourceRecord record
            in client.lookup<IPAddressResourceRecord>(
                ResourceRecordQuery.addressIPv4(srv.target))) {
          if (ptr.domainName == "unprovisioned._alexandergherardi._tcp.local") {
            var r = new Record();
            r.address = record.address.address;
            r.provisioned = false;
            records.add(r);
          } else if (ptr.domainName == "hub._alexandergherardi._tcp.local") {
            var r = new Record();
            r.address = record.address.address;
            r.provisioned = true;
            records.add(r);
          }
          yield records;
        }
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(
                  15,
                  MediaQuery.of(context).padding.top + 15,
                  15,
                  15,
                ),
                child: Text(
                  "Available Hubs",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
          ),
          StreamBuilder(
            builder: (context, AsyncSnapshot<List<Record>> snapshot) {
              if (snapshot.hasData) {
                return HubList(
                  snapshot: snapshot,
                );
              } else {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
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
    );
  }
}

class HubList extends StatefulWidget {
  final AsyncSnapshot<List<Record>> snapshot;

  const HubList({Key key, this.snapshot}) : super(key: key);

  @override
  _HubListState createState() => _HubListState();
}

class _HubListState extends State<HubList> {
  int _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return SelectableListItem(
              widget.snapshot.data.elementAt(index).address, () {
            setState(() {
              _selectedIndex = index;
            });
            Provider.of<OnboardingModel>(context, listen: false).provisioned =
                widget.snapshot.data.elementAt(index).provisioned;
            Provider.of<ClientModel>(context, listen: false)
                .setHost(widget.snapshot.data.elementAt(index).address);
          }, (_selectedIndex == index) ? true : false);
        },
        childCount: widget.snapshot.data.length,
      ),
    );
  }
}
