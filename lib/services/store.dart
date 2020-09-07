import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> deleteConnectionData() async {
  SharedPreferences storage = await SharedPreferences.getInstance();
  // Remove old values
  await storage.remove("address");
  await storage.remove("webKey");
}

Future<void> saveConnectionData(
  String address,
  String webKey,
) async {
  SharedPreferences storage = await SharedPreferences.getInstance();
  // Remove old values
  await storage.remove("address");
  await storage.remove("webKey");
  // Save values
  print(address);
  print(webKey);
  await storage.setString("address", address);
  await storage.setString("webKey", webKey);
}

Future<ClientModel> getClientModel() async {
  SharedPreferences storage = await SharedPreferences.getInstance();
  String address = storage.getString("address");
  String webKey = storage.getString("webKey");
  // Make model and set webKey
  var model = ClientModel(address);
  model.webKey = webKey;
  return model;
}

class ClientModel {
  ClientModel(String address) {
    setHost(address);
    host = address;
  }
  String webKey;
  String host = "";
  ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
    cache: InMemoryCache(),
    link: WebSocketLink(url: ""),
  ));
  void setHost(String address) {
    if (address != null) {
      client.value = GraphQLClient(
        cache: InMemoryCache(),
        link: WebSocketLink(url: "ws://" + address + ":8080/graphql"),
      );
      host = address;
    }
  }
}
