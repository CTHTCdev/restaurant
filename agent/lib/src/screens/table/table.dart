import 'package:agent/src/screens/table/table_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:agent/src/extensions/responsive.dart';
import 'package:agent/src/global/states/status.dart';
import 'package:agent/src/models/table.dart';
import 'package:agent/src/screens/home.dart';
import 'package:agent/src/screens/home/home_bloc.dart';

class TableScreen extends StatefulWidget {
  TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
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

  Widget _tableBuilder() {
    return Center(
      child: MasonryGridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        // crossAxisCount: (MediaQuery.of(context).size.width ~/
        //     (MediaQuery.of(context).size.height / 8)),
        crossAxisCount: (context.responsive(df: 4, sm: 5, md: 6, lg: 8, xl: 9)),

        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: allTables.length,
        itemBuilder: (context, index) {
          return _buttonBuilder(
            table: TableNow(
              allTables[index].index,
              allTables[index].status,
              allTables[index].hasLocked,
            ),
          );
        },
      ),
    );
  }

  Widget _buttonBuilder({required TableNow table}) {
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
            color: table.status.values.elementAt(0),
            shape: NeumorphicShape.concave,
            surfaceIntensity: 0.1,
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(0),
            ),
          ),
          child: Center(
            child: Text(
              'TABLE ' + table.index.toString(),
              textAlign: TextAlign.center,
            ),
          ),
          onPressed: () {
            setState(() {
              context
                  .read<HomeBloc>()
                  .add(TableName_HomeEvent(name: table.index.toString()));
            });

            // print("Now " + widget.index);
            // Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      HomeScreen(tab: {1: table.index.toString()}),
                ));
          },
        );
      },
    );
  }
}
