import 'package:agent/src/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'src/screens/home/home_bloc.dart';
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
      home: HomeScreen(
        tab: {2: 'TAKEAWAY'},
      ),
      theme: TrendingTheme.lightTheme(),
      themeMode: ThemeMode.light,
    );
  }
}
