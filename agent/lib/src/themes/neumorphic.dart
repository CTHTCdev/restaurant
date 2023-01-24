import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

const GoldenColour = const Color(0x0FFEEBC1D);
const BlackenColour = Colors.black;

const PrimaryColor = const Color(0xFFE0E5EC);
const PrimaryColorLight = const Color(0xFFFFFFFFF);
const PrimaryColorDark = const Color(0xFFA3B1C6);
const PrimaryColorDisable = const Color(0x5EA3B1C6);

class TrendingTheme {
  static NeumorphicThemeData darkTheme() {
    return NeumorphicThemeData(
      appBarTheme: const NeumorphicAppBarThemeData(),
      baseColor: Color(0xFF3E3E3E),
      lightSource: LightSource.topLeft,
      depth: 6,
    );
  }

  static NeumorphicThemeData lightTheme() {
    return NeumorphicThemeData(
      appBarTheme: const NeumorphicAppBarThemeData(),
      baseColor: Color(0xffDDDDDD),
      lightSource: LightSource.topLeft,
      depth: 10,
    );
  }
}
