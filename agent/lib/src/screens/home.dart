import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:split_view/split_view.dart';

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
    return SafeArea(child: _displayFrame());
  }

  Widget _displayFrame() {
    return SplitView(
      gripSize: 10,
      viewMode: SplitViewMode.Horizontal,
      indicator: SplitIndicator(viewMode: SplitViewMode.Horizontal),
      controller: SplitViewController(weights: [0.7]),
      children: [
        SplitView(
          gripSize: 10,
          viewMode: SplitViewMode.Vertical,
          indicator: SplitIndicator(viewMode: SplitViewMode.Vertical),
          controller: SplitViewController(weights: [0.4]),
          children: [_topLeftBuilder(), _bottomLeftBuilder()],
        ),
        Container(),
      ],
    );
  }

  Widget _topLeftBuilder() {
    return MasonryGridView.count(
      crossAxisCount: (MediaQuery.of(context).size.width ~/
          (MediaQuery.of(context).size.height / 5)),
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      itemCount: 20,
      itemBuilder: (context, index) {
        return _buttonBuilder(text: 'Category\n-------\nItem');
      },
    );
  }

  Widget _bottomLeftBuilder() {
    return MasonryGridView.count(
      padding: EdgeInsets.only(top: 10),
      crossAxisCount: (MediaQuery.of(context).size.width ~/
          (MediaQuery.of(context).size.height / 8)),
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      itemCount: 20,
      itemBuilder: (context, index) {
        return _buttonBuilder(text: 'Menu\n-------\nItem');
      },
    );
  }

  // Widget _actionFrame() {
  //   return Container(
  //     height: 100,
  //     color: Colors.amber,
  //   );
  // }

  Widget _buttonBuilder({required String text}) {
    return NeumorphicButton(
      duration: Duration(milliseconds: 25),
      padding: EdgeInsets.symmetric(vertical: 15),
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        // surfaceIntensity: 0.25,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(3),
        ),
      ),
      child: Center(child: Text(text)),
      onPressed: () {
        // print('width' + MediaQuery.of(context).size.width.toString());
        // print('height' + MediaQuery.of(context).size.height.toString());
      },
    );
  }
}
