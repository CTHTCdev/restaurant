import 'package:flutter/material.dart';

class TableNow {
  final int index;
  final Map<String, Color> status;
  final Map<bool, int> hasLocked;
  TableNow(
    this.index,
    this.status,
    this.hasLocked,
  );
}
