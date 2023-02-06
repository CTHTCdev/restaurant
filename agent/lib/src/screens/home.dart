import 'dart:collection';
import 'dart:math';

import 'package:agent/src/extensions/responsive.dart';
import 'package:agent/src/screens/settings.dart';
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
  bool _isOnline = false;
  int _tabIndex = 2;

  @override
  Widget build(BuildContext context) {
    return context.responsive(
      df: _mainVertiBuilder(),
      md: _mainHorizBuilder(),
    );
  }

  // int tab = 0;
  Widget _tabButton({
    required String name,
    required double size,
    required IconData iconData,
  }) {
    return Center(
      child: InkWell(
        onTap: () {},
        child: context.responsive(
          df: Icon(
            iconData,
            size: size,
          ),
          md: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.values[(size ~/ 6)],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tabBuilder({required bool disableDepth}) {
    return SafeArea(
      child: NeumorphicToggle(
        height: 50,
        duration: Duration(milliseconds: 100),
        style: NeumorphicToggleStyle(
          disableDepth: disableDepth,
          borderRadius: BorderRadius.zero,
        ),
        selectedIndex: _tabIndex,
        children: [
          ToggleElement(
            background: _tabButton(
              name: 'Book Now',
              size: 20,
              iconData: Icons.menu_book_rounded,
            ),
            foreground: _tabButton(
              name: 'Reserved',
              size: 30,
              iconData: Icons.menu_book_rounded,
            ),
          ),
          ToggleElement(
            background: _tabButton(
              name: 'Table Now',
              size: 20,
              iconData: Icons.local_dining_rounded,
            ),
            foreground: _tabButton(
              name: 'Dine In',
              size: 30,
              iconData: Icons.local_dining_rounded,
            ),
          ),
          ToggleElement(
            background: _tabButton(
              name: 'Order Now',
              size: 20,
              iconData: Icons.delivery_dining_rounded,
            ),
            foreground: _tabButton(
              name: 'Takeaway',
              size: 30,
              iconData: Icons.delivery_dining_rounded,
            ),
          ),
          ToggleElement(
            background: _tabButton(
              name: 'Preview',
              size: 20,
              iconData: Icons.folder_open_rounded,
            ),
            foreground: _tabButton(
              name: 'Current',
              size: 30,
              iconData: Icons.folder_open_rounded,
            ),
          ),
          ToggleElement(
            background: _tabButton(
              name: 'Takings',
              size: 20,
              iconData: Icons.bar_chart_rounded,
            ),
            foreground: _tabButton(
              name: 'Report',
              size: 30,
              iconData: Icons.bar_chart_rounded,
            ),
          ),
          ToggleElement(
            background: _tabButton(
              name: 'Settings',
              size: 20,
              iconData: Icons.settings_rounded,
            ),
            foreground: _tabButton(
              name: 'Admins',
              size: 30,
              iconData: Icons.settings_rounded,
            ),
          ),
        ],
        thumb: Neumorphic(
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.zero),
          ),
        ),
        onChanged: (value) {
          setState(() {
            if (value != 5) _tabIndex = value;
          });

          switch (value) {
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
      title: Text('STORE'),
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
      children: [_categoriesBuilder(), _itemsBuilder()],
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

  Widget _categoriesBuilder() {
    return Stack(children: [
      MasonryGridView.count(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        // crossAxisCount: (MediaQuery.of(context).size.width ~/
        //     (MediaQuery.of(context).size.height / 5)),
        crossAxisCount: (context.responsive(df: 3, sm: 4, md: 5, lg: 6, xl: 8)),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: 20,
        itemBuilder: (context, index) {
          return _buttonBuilder(text: 'Category Category Category Category');
        },
      ),
      NeumorphicButton(
        duration: Duration(milliseconds: 25),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        style: NeumorphicStyle(
          shape: NeumorphicShape.concave,
          surfaceIntensity: 0.1,
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.zero,
          ),
        ),
        child: Icon(Icons.search),
        onPressed: () {},
      ),
    ]);
  }

  Widget _itemsBuilder() {
    return MasonryGridView.count(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      // crossAxisCount: (MediaQuery.of(context).size.width ~/
      //     (MediaQuery.of(context).size.height / 8)),
      crossAxisCount: (context.responsive(df: 4, sm: 5, md: 6, lg: 8, xl: 9)),

      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      itemCount: 20,
      itemBuilder: (context, index) {
        return _buttonBuilder(text: 'Menu Menu Menu Menu');
      },
    );
  }

  Widget _buttonBuilder({required String text}) {
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
        // print('TAB is ' + tab.toString());
      },
    );
  }
}
