import 'package:flutter/material.dart';

List<Map<int, Tab>> tabs = [
  {
    0: Tab('BookNow', {20: Icons.menu_book_rounded})
  },
  {
    0: Tab('Reserved', {30: Icons.menu_book_rounded})
  },
  {
    1: Tab('TableNow', {20: Icons.local_dining_rounded})
  },
  {
    1: Tab('DineIn', {30: Icons.local_dining_rounded})
  },
  {
    2: Tab('OrderNow', {20: Icons.delivery_dining_rounded})
  },
  {
    2: Tab('Takeaway', {30: Icons.delivery_dining_rounded})
  },
  {
    3: Tab('Preview', {20: Icons.folder_open_rounded})
  },
  {
    3: Tab('Current', {30: Icons.folder_open_rounded})
  },
  {
    4: Tab('Takings', {20: Icons.bar_chart_rounded})
  },
  {
    4: Tab('Report', {30: Icons.bar_chart_rounded})
  },
  {
    5: Tab('Settings', {20: Icons.settings_rounded})
  },
  {
    5: Tab('Admins', {30: Icons.settings_rounded})
  },
];

class Tab {
  final String name;
  final Map<int, IconData> icon;
  Tab(
    this.name,
    this.icon,
  );
}
