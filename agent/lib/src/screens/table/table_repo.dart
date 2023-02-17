import 'package:agent/src/models/table.dart';

class TableNowRepository {
  TableNowRepository._();
  static final TableNowRepository instance = TableNowRepository._();

  List<TableNow> listTable = [];
}
