import 'package:agent/src/extensions/responsive.dart';
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
    return context.responsive(
      df: _mainVertiBuilder(),
      sm: _mainHorizBuilder(),
    );
  }

  Widget _mainVertiBuilder() {
    return Scaffold(
      appBar: _appBarVerti(),
      drawer: Drawer(child: Text('Drawer')),
      body: _bodyVertiFrame(),
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
      title: Text('Vertical'),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.assignment_outlined))
      ],
    );
  }

  NeumorphicAppBar _appBarHoriz() {
    return NeumorphicAppBar(
      padding: 5,
      leading: IconButton(
          onPressed: () {}, icon: Icon(Icons.circle, color: Colors.green)),
      title: _tabBuilder(),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.person_rounded)),
      ],
    );
  }

  int _selectedIndex = 2;
  Widget _tabBuilder() {
    return NeumorphicToggle(
      height: 50,
      duration: Duration(milliseconds: 100),
      style: NeumorphicToggleStyle(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        // backgroundColor: Colors.red,
      ),
      selectedIndex: _selectedIndex,
      displayForegroundOnlyIfSelected: true,
      children: [
        ToggleElement(
          background: Center(
              child: Text(
            "Book Now",
            style: TextStyle(fontWeight: FontWeight.w200),
          )),
          foreground: Center(
              child: Text(
            "Reserved",
            style: TextStyle(fontWeight: FontWeight.w600),
          )),
        ),
        ToggleElement(
          background: Center(
              child: Text(
            "Table Now",
            style: TextStyle(fontWeight: FontWeight.w200),
          )),
          foreground: Center(
              child: Text(
            "Dine In",
            style: TextStyle(fontWeight: FontWeight.w600),
          )),
        ),
        ToggleElement(
          background: Center(
              child: Text(
            "Order Now",
            style: TextStyle(fontWeight: FontWeight.w200),
          )),
          foreground: Center(
              child: Text(
            "Takeaway",
            style: TextStyle(fontWeight: FontWeight.w600),
          )),
        ),
        ToggleElement(
          background: Center(
              child: Text(
            "Openned",
            style: TextStyle(fontWeight: FontWeight.w200),
          )),
          foreground: Center(
              child: Text(
            "Preview",
            style: TextStyle(fontWeight: FontWeight.w600),
          )),
        ),
        ToggleElement(
          background: Center(
              child: Text(
            "Takings",
            style: TextStyle(fontWeight: FontWeight.w200),
          )),
          foreground: Center(
              child: Text(
            "Report",
            style: TextStyle(fontWeight: FontWeight.w600),
          )),
        ),
        ToggleElement(
          background: Center(
              child: Text(
            "Settings",
            style: TextStyle(fontWeight: FontWeight.w200),
          )),
          foreground: Center(
              child: Text(
            "Admin",
            style: TextStyle(fontWeight: FontWeight.w600),
          )),
        ),
      ],
      thumb: Neumorphic(
        style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.all(Radius.circular(5))),
        ),
      ),
      onChanged: (value) {
        setState(() {
          _selectedIndex = value;
          print("_firstSelected: $_selectedIndex");
          print('test' + MediaQuery.of(context).orientation.index.toString());
        });
      },
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
          context.responsive(df: 1, sm: 0.6, md: 0.65, lg: 0.7, xl: 0.75),
        ],
        limits: [
          context.responsive(
            df: WeightLimit(min: 1, max: 1),
            sm: WeightLimit(min: 0.6, max: 0.6),
            md: WeightLimit(min: 0.65, max: 0.65),
            lg: WeightLimit(min: 0.7, max: 0.7),
            xl: WeightLimit(min: 0.75, max: 0.75),
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
            BorderRadius.circular(0),
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
      onPressed: () {},
    );
  }
}
