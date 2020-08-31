import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

Future<void> deleteConnectionData() async {
  final storage = new FlutterSecureStorage();
  // Remove values
  await storage.deleteAll();
}

Future<void> saveConnectionData(
  String address,
  String webKey,
) async {
  final storage = new FlutterSecureStorage();
  // Remove old values
  await storage.deleteAll();
  // Save values
  print(address);
  print(webKey);
  await storage.write(key: "address", value: address);
  await storage.write(key: "webKey", value: webKey);
}

Future<ClientModel> getClientModel() async {
  final storage = new FlutterSecureStorage();
  String address = await storage.read(key: "address");
  String webKey = await storage.read(key: "webKey");
  // Make model and set webKey
  var model = ClientModel(address);
  model.webKey = webKey;
  return model;
}

class ClientModel {
  ClientModel(String address) {
    setHost(address);
  }
  String webKey;
  ValueNotifier<GraphQLClient> client = ValueNotifier(null);
  void setHost(String host) {
    if (host != null) {
      client.value = GraphQLClient(
        cache: InMemoryCache(),
        link: WebSocketLink(url: "ws://" + host + ":8080/graphql"),
      );
    }
  }
}
