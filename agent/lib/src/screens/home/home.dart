import 'dart:collection';
import 'dart:math';

import 'package:agent/src/global/states/status.dart';
import 'package:agent/src/models/category.dart';
import 'package:agent/src/models/menu.dart';
import 'package:agent/src/screens/category/category.dart';
import 'package:agent/src/screens/category/category_bloc.dart';
import 'package:agent/src/screens/home/home_data.dart';
import 'package:agent/src/screens/menu/menu_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:split_view/split_view.dart';

import 'package:agent/src/extensions/responsive.dart';
import 'package:agent/src/screens/home/home_bloc.dart';
import 'package:agent/src/screens/settings.dart';
import 'package:agent/src/screens/table/table.dart';

class HomeScreen extends StatefulWidget {
  Map<int, String> tab;
  HomeScreen({
    Key? key,
    required this.tab,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isOnline = false;
  int _tabIndex = 2;
  @override
  void initState() {
    // TODO: implement initState
    // widget.tab.entries;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return context.responsive(
      df: _mainVertiBuilder(),
      md: _mainHorizBuilder(),
    );
  }

  // int tab = 0;
  Widget _tabButton(int index) {
    Map<int, IconData> icon = tabs[index].values.single.icon;
    return Center(
      child: InkWell(
        child: context.responsive(
          df: Icon(
            icon.values.single,
            size: icon.keys.single.toDouble(),
          ),
          md: Text(
            tabs[index].values.single.name,
            style: TextStyle(
              fontWeight: FontWeight.values[(icon.keys.single.toDouble() ~/ 6)],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tabBuilder({required bool disableDepth}) {
    return SafeArea(
      child: NeumorphicToggle(
        height: 60,
        duration: Duration(milliseconds: 100),
        style: NeumorphicToggleStyle(
          disableDepth: disableDepth,
          borderRadius: BorderRadius.zero,
        ),
        selectedIndex: widget.tab.entries.first.key,
        children: [
          ToggleElement(
            background: _tabButton(0),
            foreground: _tabButton(1),
          ),
          ToggleElement(
            background: _tabButton(2),
            foreground: _tabButton(3),
          ),
          ToggleElement(
            background: _tabButton(4),
            foreground: _tabButton(5),
          ),
          ToggleElement(
            background: _tabButton(6),
            foreground: _tabButton(7),
          ),
          ToggleElement(
            background: _tabButton(8),
            foreground: _tabButton(9),
          ),
          ToggleElement(
            background: _tabButton(10),
            foreground: _tabButton(11),
          ),
        ],
        thumb: Neumorphic(
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.zero),
          ),
        ),
        onChanged: (value) {
          switch (value) {
            case 1:
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TableScreen()));

              break;
            case 5:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()));
              break;
            default:
          }
        },
      ),
    );
  }

  Widget _mainVertiBuilder() {
    return Scaffold(
      appBar: _appBarVerti(),
      body: _bodyVertiFrame(),
      bottomNavigationBar: _tabBuilder(disableDepth: true),
      // _tabVertiBuilder(index: 0, iconData: Icons.menu_book_rounded),
      // _tabVertiBuilder(index: 1, iconData: Icons.local_dining_rounded),
      // _tabVertiBuilder(index: 2, iconData: Icons.delivery_dining_rounded),
      // _tabVertiBuilder(index: 3, iconData: Icons.folder_open_rounded),
      // _tabVertiBuilder(index: 4, iconData: Icons.bar_chart_rounded),
      // _tabVertiBuilder(index: 5, iconData: Icons.settings),
    );
  }

  Widget _mainHorizBuilder() {
    return Scaffold(
      appBar: _appBarHoriz(),
      body: _bodyHorizFrame(),
    );
  }

  NeumorphicAppBar _appBarVerti() {
    return NeumorphicAppBar(
      title: Text(widget.tab.entries.single.value),
      padding: 0,
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.assignment_outlined))
      ],
      leading: _onlineStatusBuilder(),
    );
  }

  Widget _onlineStatusBuilder() {
    return IconButton(
      onPressed: () {
        setState(() {
          _isOnline = !_isOnline;
        });
      },
      icon: Icon(
        Icons.circle,
        color: _isOnline ? Colors.green : Colors.red,
        size: 20,
      ),
    );
  }

  NeumorphicAppBar _appBarHoriz() {
    return NeumorphicAppBar(
      padding: 5,
      leading: _onlineStatusBuilder(),
      title: _tabBuilder(disableDepth: false),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.person_rounded)),
      ],
    );
  }

  Widget _bodyVertiFrame() {
    return SplitView(
      gripSize: 10,
      viewMode: SplitViewMode.Vertical,
      indicator: SplitIndicator(viewMode: SplitViewMode.Vertical),
      controller: SplitViewController(weights: [0.4]),
      children: [CategoryScreen(), _itemsBuilder()],
    );
  }

  Widget _bodyHorizFrame() {
    return SplitView(
      gripSize: 10,
      viewMode: SplitViewMode.Horizontal,
      indicator: SplitIndicator(viewMode: SplitViewMode.Horizontal),
      // controller: _splitController(),
      controller: SplitViewController(
        weights: [
          context.responsive(df: 1, md: 0.6, lg: 0.65, xl: 0.7),
        ],
        limits: [
          context.responsive(
            df: WeightLimit(min: 1, max: 1),
            md: WeightLimit(min: 0.6, max: 0.65),
            lg: WeightLimit(min: 0.65, max: 0.7),
            xl: WeightLimit(min: 0.7, max: 0.75),
          )
        ],
      ),
      children: [
        _bodyVertiFrame(),
        Container(),
      ],
    );
  }

  List<MenuNow> menus = [];
  Widget _itemsBuilder() {
    return BlocProvider(
      create: (context) => MenuBloc()..add(Fetch_MenuEvent()),
      child: BlocConsumer<MenuBloc, MenuState>(
        listener: (context, state) {
          if (state.status is StatusSucess) {
            // print("hello" + state.menus!.length.toString());
          }
        },
        builder: (context, state) {
          return MasonryGridView.count(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            // crossAxisCount: (MediaQuery.of(context).size.width ~/
            //     (MediaQuery.of(context).size.height / 8)),
            crossAxisCount:
                (context.responsive(df: 4, sm: 5, md: 6, lg: 8, xl: 9)),

            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            itemCount: 20,
            itemBuilder: (context, index) {
              return _buttonBuilder(object: 'Menu Menu Menu Menu');
            },
          );
        },
      ),
    );
  }

  Widget _buttonBuilder({required Object object}) {
    String name = "TEST";
    return NeumorphicButton(
      duration: Duration(milliseconds: 25),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      style: NeumorphicStyle(
        // color: Color(),
        shape: NeumorphicShape.concave,
        surfaceIntensity: 0.1,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(0),
        ),
      ),
      child: Center(
        child: Text(name, textAlign: TextAlign.center),
      ),
      onPressed: () {},
    );
  }
}
