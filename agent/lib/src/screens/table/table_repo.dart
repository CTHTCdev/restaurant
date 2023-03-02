import 'package:agent/src/global/services/graphql.dart';
import 'package:agent/src/models/table.dart';
import 'package:agent/src/screens/table/table_fragment.dart';
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
    print(tables);
    // Assign model
    if (tables.isNotEmpty) {
      return (tables as List)
          .map((table) => TableNow.fromMap(table))
          .toList();
    }
    return [];
  }

  static const String FETCH_ALL_TABLE = '''
    ${TableFragment.TABLE_PROPS}
    query ListTable{
      table {
        id
        table_name
        table_status
        table_locked
        table_assigned
        props {
          ...TableProps
        }
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

class TablePropsRepo {
  TablePropsRepo._();
  static final TablePropsRepo instance = TablePropsRepo._();

  // Future<TableProps> getTableProps() async {
  void getTableProps() async {
    // return QueryResult from Future<>
    final QueryResult result = await GraphQlService.performQuery(
      document: GET_TABLE_PROPS_BY_ID,
    );
    final table_props = result.data?['table_props_by_pk'];
    // print(table_props);
    // Assign model
    
  }

  static const String GET_TABLE_PROPS_BY_ID = '''
    query MyQuery {
      table_props_by_pk(id: 1) {
        id
        table_dx
        table_dy
        table_len
        table_wid
        table_type
      }
    }
  ''';
}
