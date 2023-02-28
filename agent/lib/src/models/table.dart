import 'package:flutter/material.dart';

class TableNow {
  final String id;
  final String name;
  final String status;
  final bool isLocked;
  final int assignee;
  final String type;

  TableNow({
    required this.id, 
    required this.name, 
    required this.status, 
    required this.isLocked, 
    required this.assignee,
    required this.type});


  TableNow copyWith({
    String? id,
    String? name,
    String? status,
    bool? isLocked,
    int? assignee,
    String? type,
  }) {
    return TableNow(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      isLocked: isLocked ?? this.isLocked,
      assignee: assignee ?? this.assignee,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'isLocked': isLocked,
      'assignee': assignee,
      'type': type
    };
  }

  factory TableNow.fromMap(Map<String, dynamic> map) {
    return TableNow(
      id: map['id'] ?? '',
      name: map['table_name'] ?? '',
      status: map['table_status'] ?? '',
      isLocked: map['table_locked'] ?? false,
      assignee: map['table_assigned'] ?? 0,
      type: map['table_type'] ?? '',
    );
  }
}
