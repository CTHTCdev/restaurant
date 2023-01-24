import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('R-A')),
      body: _bodyBuilder(),
    );
  }

  Widget _bodyBuilder() {
    return SafeArea(
      minimum: EdgeInsets.all(15),
      child: MasonryGridView.count(
        crossAxisCount: (MediaQuery.of(context).size.width ~/ 100),
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        itemCount: 10,
        itemBuilder: (context, index) {
          return _buttonBuilder(text: 'Menu\n-------\nItem');
        },
      ),
    );
  }

  Widget _buttonBuilder({required String text}) {
    return NeumorphicButton(
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(5),
        ),
      ),
      child: Center(child: Text(text)),
      onPressed: () {},
    );
  }
}
