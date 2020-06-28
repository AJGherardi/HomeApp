import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

Future<void> saveConnectionData(
  String address,
  String webKey,
) async {
  final storage = new FlutterSecureStorage();
  // Remove old values
  await storage.deleteAll();
  // Save values
  await storage.write(key: "address", value: address);
  await storage.write(key: "webKey", value: webKey);
}

class ConnectionData {
  ConnectionData(String address, String webkey) {
    this.address = address;
    this.webKey = webKey;
  }
  String address, webKey;
}

Future<ClientModel> getClientModel() async {
  final storage = new FlutterSecureStorage();
  await storage.deleteAll();
  String address = await storage.read(key: "address");
  String webKey = await storage.read(key: "webKey");
  return ClientModel(address, webKey);
}

class ClientModel {
  ClientModel(String address, String webkey) {
    setHost(address);
    this.webKey = webKey;
  }
  String webKey;
  ValueNotifier<GraphQLClient> client = ValueNotifier(null);
  void setHost(String host) {
    if (host != null) {
      client.value = GraphQLClient(
        cache: InMemoryCache(),
        link: HttpLink(uri: "http://" + host + ":8080/graphql"),
      );
    }
  }
}
