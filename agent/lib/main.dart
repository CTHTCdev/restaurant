import 'package:agent/src/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'src/themes/neumorphic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      title: 'AGENT',
      home: HomeScreen(),
      theme: TrendingTheme.lightTheme(),
      themeMode: ThemeMode.light,
    );
  }
}
