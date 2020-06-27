import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MutationWithoutWebKey extends StatelessWidget {
  MutationWithoutWebKey({
    @required this.onCompleted,
    @required this.query,
    @required this.builder,
  });
  final String query;
  final MutationBuilder builder;
  final Function(dynamic resultData) onCompleted;

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
        documentNode: gql(query),
        onCompleted: onCompleted,
        onError: (OperationException error) {
          print(error);
        },
        update: (Cache cache, QueryResult result) {
          return cache;
        },
      ),
      builder: builder,
    );
  }
}

class ClientModel {
  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: InMemoryCache(),
      link: HttpLink(uri: "sss"),
    ),
  );
  void setHost(String host) {
    client.value = GraphQLClient(
      cache: InMemoryCache(),
      link: HttpLink(uri: "http://" + host + ":8080/graphql"),
    );
  }
}
