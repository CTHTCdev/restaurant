import 'dart:html';

import 'package:agent/src/models/category.dart';
import 'package:agent/src/screens/category/category_repo.dart';
import 'package:agent/src/screens/table/table_bloc.dart';
import 'package:agent/src/screens/table/table_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:agent/src/extensions/responsive.dart';
import 'package:agent/src/global/states/status.dart';
import 'package:agent/src/models/table.dart';
import 'package:agent/src/screens/home/home.dart';
import 'package:agent/src/screens/home/home_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class TableScreen extends StatefulWidget {
  TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  List<TableNow> tables = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(
        appBar: NeumorphicAppBar(title: Text('Select Table')),
        body: _tableBuilder(),
      ),
    );
  }

  // Widget _tableBuilder() {
  //   return Subscription(
  //     options: SubscriptionOptions(document: gql(TableRepo.STREAM_TABLE)),
  //     builder: (result) {
  //       print(result);
  //       return Text('data');
  //     },
  //   );
  // }
  Widget _tableBuilder() {
    return BlocProvider(
      create: (context) => TableBloc()..add(Fetch_TableEvent()),
      child: BlocConsumer<TableBloc, TableState>(
        listener: (context, state) {
          if (state.status is StatusSucess) {
            setState(() {
              tables = state.tables!;
            });
          } else {
            print('cannot fetch TABLE');
          }
        },
        builder: (context, state) {
          return Stack(
            children: List.generate(
              tables.length,
              (index) {
                return _buttonBuilder(
                    index: index,
                    table: TableNow(
                      id: tables[index].id,
                      name: tables[index].name,
                      status: tables[index].status,
                      isLocked: tables[index].isLocked,
                      assignee: tables[index].assignee,
                      props: tables[index].props,
                    ));
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buttonBuilder({required TableNow table, required int index}) {
    bool isRound = table.props!.type == "ROUND";
    bool isEqual = table.props!.type != "RECT";
    double seat = table.props!.seat * 2;
    double length = (isEqual ? seat : seat / 2);
    double width = isEqual ? seat : seat * 2;

    final child = NeumorphicButton(
      duration: Duration(milliseconds: 25),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        surfaceIntensity: 0.1,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(isRound ? seat * 10 : 0),
        ),
      ),
      child: SizedBox(
        height: length * context.responsive(df: 6, md: 8, xl: 10),
        width: width * context.responsive(df: 6, md: 8, xl: 10),
        child: Center(
          child: Text(
            table.name,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      onPressed: () async {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(tab: {1: table.name}),
            ));
      },
    );

    return Positioned(
      top: table.props!.dy,
      left: table.props!.dx,
      child: Draggable(
        onDragUpdate: (details) {
          table.props!.dx += details.delta.dx;
          table.props!.dy += details.delta.dy;
          setState(() {});
        },
        feedback: child,
        child: child,
      ),
    );
  }
}
