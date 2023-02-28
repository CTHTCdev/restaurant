import 'package:agent/src/models/category.dart';
import 'package:agent/src/screens/category/category_repo.dart';
import 'package:agent/src/screens/table/table_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:agent/src/extensions/responsive.dart';
import 'package:agent/src/global/states/status.dart';
import 'package:agent/src/models/table.dart';
import 'package:agent/src/screens/home/home.dart';
import 'package:agent/src/screens/home/home_bloc.dart';

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
            print('cannot fetch');
          }
        },
        builder: (context, state) {
          return Center(
            child: MasonryGridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              // crossAxisCount: (MediaQuery.of(context).size.width ~/
              //     (MediaQuery.of(context).size.height / 8)),
              crossAxisCount:
                  (context.responsive(df: 4, sm: 5, md: 6, lg: 8, xl: 9)),

              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              itemCount: tables.length,
              itemBuilder: (context, index) {
                return _buttonBuilder(
                  table: TableNow(
                    id: tables[index].id, 
                    name: tables[index].name, 
                    status: tables[index].status, 
                    isLocked: tables[index].isLocked, 
                    assignee: tables[index].assignee, 
                    type: tables[index].type
                  )
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buttonBuilder({required TableNow table}) {
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
          table.name,
          textAlign: TextAlign.center,
        ),
      ),
      onPressed: () async {
        
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  HomeScreen(tab: {1: table.name}),
            ));
      },
    );
  }
}
