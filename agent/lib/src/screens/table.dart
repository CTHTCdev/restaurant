import 'package:agent/src/extensions/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TableScreen extends StatefulWidget {
  
  const TableScreen({super.key, required int tableIndex});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tableBuilder()
    );
  }

  Widget _tableBuilder() {
    return MasonryGridView.count(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      // crossAxisCount: (MediaQuery.of(context).size.width ~/
      //     (MediaQuery.of(context).size.height / 8)),
      crossAxisCount: (context.responsive(df: 4, sm: 5, md: 6, lg: 8, xl: 9)),

      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      itemCount: 20,
      itemBuilder: (context, index) {
        return _buttonBuilder(text: 'Table ' + index.toString(), tableIndex: index);
      },
    );
  }
  
  Widget _buttonBuilder({required String text, required int tableIndex}) {
    return NeumorphicButton(
      duration: Duration(milliseconds: 25),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        surfaceIntensity: 0.1,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(0),
        ),
      ),
      child: Center(
          child: Text(
        text,
        textAlign: TextAlign.center,
      )),
      onPressed: () {
        print(tableIndex);
        Navigator.pop(context);
      },
    );
  }
}

