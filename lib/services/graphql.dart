import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MutationWithBuilder extends StatelessWidget {
  MutationWithBuilder({
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
