import 'dart:ui';

import 'package:agent/src/models/table.dart';
import 'package:flutter/material.dart';

List<Map<String, Color>> status = [
  {"EMPTY": Colors.white},
  {"TAKING": Colors.blue},
  {"SENDING": Colors.green},
  {"PAYING": Colors.red}
];

List<TableNow> allTables = [
  TableNow(0, status[0], {false: 0}),
  TableNow(1, status[1], {false: 0}),
  TableNow(2, status[2], {false: 0}),
  TableNow(3, status[3], {false: 0}),
  TableNow(4, status[0], {false: 0}),
  TableNow(5, status[1], {false: 0}),
  TableNow(6, status[2], {false: 0}),
  TableNow(7, status[3], {false: 0}),
  TableNow(8, status[0], {false: 0}),
  TableNow(9, status[1], {false: 0}),
  TableNow(10, status[2], {false: 0}),
  TableNow(11, status[3], {false: 0}),
  TableNow(12, status[0], {false: 0}),
  TableNow(13, status[1], {false: 0}),
  TableNow(14, status[2], {false: 0}),
  TableNow(15, status[3], {false: 0}),
];
