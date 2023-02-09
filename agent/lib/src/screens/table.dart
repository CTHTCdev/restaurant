import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:agent/src/extensions/responsive.dart';
import 'package:agent/src/global/state/status.dart';
import 'package:agent/src/screens/home.dart';
import 'package:agent/src/screens/home/home_bloc.dart';

class TableScreen extends StatefulWidget {
  TableScreen({super.key, required String tableIndex});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(body: _tableBuilder()),
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
        return _buttonBuilder(
            text: 'Table ' + index.toString(), tableIndex: index);
      },
    );
  }

  Widget _buttonBuilder({required String text, required int tableIndex}) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (widget, state) {
        if (state.status is StatusSucess) {
          print("STATE: " + state.name);
        }
      },
      builder: (context, state) {
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
            ),
          ),
          onPressed: () {
            setState(() {
              context
                  .read<HomeBloc>()
                  .add(TableName_HomeEvent(name: tableIndex.toString()));
            });

            // print("Now " + widget.index);
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        HomeScreen(index: tableIndex.toString())));
          },
        );
      },
    );
  }
}
