import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

ValueNotifier<GraphQLClient> makeClient(String host) {
  return ValueNotifier(
    GraphQLClient(
      cache: InMemoryCache(),
      link: HttpLink(uri: "http://" + host + ":8080/graphql"),
    ),
  );
}

class MutationWithoutWebKey extends StatelessWidget {
  MutationWithoutWebKey({
    @required this.host,
    @required this.onCompleted,
    @required this.query,
    @required this.builder,
  });
  final String query;
  final String host;
  final MutationBuilder builder;
  final Function(dynamic resultData) onCompleted;

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: makeClient(this.host),
      child: Mutation(
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
      ),
    );
  }
}
