import 'package:agent/src/global/services/graphql.dart';
import 'package:agent/src/models/table.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class TableRepo {
  TableRepo._();
  static final TableRepo instance = TableRepo._();

  Future<List<TableNow>> fetchTables() async {
    // return QueryResult from Future<>
    final QueryResult result = await GraphQlService.performQuery(
      document: FETCH_ALL_TABLE,
    );
    final tables = result.data?['table'];
    // print(tables);
    // Assign model
    if (tables.isNotEmpty) {
      return (tables as List)
          .map((table) => TableNow.fromMap(table))
          .toList();
    }
    return [];
  }

  static const String FETCH_ALL_TABLE = '''
    query ListTable{
      table {
        id
        table_name
        table_status
        table_locked
        table_assigned
        table_type
      }
    }
  ''';


  Stream<QueryResult> streamTables() {
    // return QueryResult from Future<>
    final Stream<QueryResult> subscription = GraphQlService.performSubscribe(
      document: STREAM_TABLE,
    );
    // print(tables);
    subscription.listen((result) {
      (result.data?['table'] as List)
        .map((table) => TableNow.fromMap(table))
        .toList();
    });

    return subscription;
  }

  static const String STREAM_TABLE = '''
    subscription SubscriptionTable {
      table {
        id
        table_name
        table_status
        table_locked
        table_assigned
        table_type
      }
    }
  ''';
}
