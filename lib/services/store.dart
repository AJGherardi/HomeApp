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

final policies = Policies(
  fetch: FetchPolicy.networkOnly,
);

class ClientModel {
  ClientModel(String address) {
    setHost(address);
    host = address;
  }
  String webKey;
  String host = "";
  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: InMemoryCache(),
      link: WebSocketLink(url: ""),
      defaultPolicies: DefaultPolicies(
        watchQuery: policies,
        query: policies,
        mutate: policies,
      ),
    ),
  );

  void setPin(int pin) {
    if (host != null) {
      client.value = GraphQLClient(
        cache: InMemoryCache(),
        link: WebSocketLink(
          url: "ws://" + host + ":8080/graphql",
          config: SocketClientConfig(
            initPayload: () => {
              'webKey': webKey,
              'pin': pin,
            },
          ),
        ),
      );
    }
  }

  void setHost(String address) {
    if (address != null) {
      client.value = GraphQLClient(
        cache: InMemoryCache(),
        link: WebSocketLink(
          url: "wss://" + address + ":2041/graphql",
          config: SocketClientConfig(
            initPayload: () => {
              'webKey': webKey,
            },
          ),
        ),
      );
      host = address;
    }
  }
}
