part of 'table_bloc.dart';

class TableState {
  final List<TableNow>? tables;
  final Status? status;

  TableState({this.tables, this.status});


  TableState copyWith({
    List<TableNow>? tables,
    Status? status,
  }) {
    return TableState(
      tables: tables ?? this.tables,
      status: status ?? this.status,
    );
  }
}