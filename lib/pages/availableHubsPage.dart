import 'dart:io';
import 'package:flutter/material.dart';
import 'package:home/components/items.dart';
import 'package:home/services/store.dart';
import 'package:multicast_dns/multicast_dns.dart';
import 'package:provider/provider.dart';

Stream<List<String>> find() async* {
  var factory =
      (dynamic host, int port, {bool reuseAddress, bool reusePort, int ttl}) {
    return RawDatagramSocket.bind(host, port,
        reuseAddress: true, reusePort: false, ttl: 1);
  };
  List<String> addresses = [];
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
          print('Found address (${record.address}).');
          addresses.add(record.address.address);
          yield addresses;
        }
      }
    }
  }
  client.stop();
  print("done");
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
            builder: (context, AsyncSnapshot<List<String>> snapshot) {
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
  final AsyncSnapshot<List<String>> snapshot;

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
          return SelectableListItem(widget.snapshot.data.elementAt(index), () {
            setState(() {
              _selectedIndex = index;
            });
            Provider.of<ClientModel>(context, listen: false)
                .setHost(widget.snapshot.data.elementAt(index));
          }, (_selectedIndex == index) ? true : false);
        },
        childCount: widget.snapshot.data.length,
      ),
    );
  }
}
