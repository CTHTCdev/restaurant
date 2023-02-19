import 'package:agent/src/extensions/responsive.dart';
import 'package:agent/src/global/states/status.dart';
import 'package:agent/src/models/category.dart';
import 'package:agent/src/screens/category/category_bloc.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return _categoriesBuilder();
  }

  List<CategoryNow> categories = [];
  Widget _categoriesBuilder() {
    return BlocProvider(
      create: (context) => CategoryBloc()..add(Fetch_CategoryEvent()),
      child: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if (state.status is StatusSucess) {
            print(state.categories!.length);
            setState(() {
              categories = state.categories!;
            });
          } else {
            print('cannot fetch');
          }
        },
        builder: (context, state) {
          return Stack(children: [
            MasonryGridView.count(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              // crossAxisCount: (MediaQuery.of(context).size.width ~/
              //     (MediaQuery.of(context).size.height / 5)),
              crossAxisCount:
                  (context.responsive(df: 3, sm: 4, md: 5, lg: 6, xl: 8)),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return _buttonBuilder(categories[index]);
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
        },
      ),
    );
  }

  Widget _buttonBuilder(CategoryNow category) {
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
        child: Text(category.name, textAlign: TextAlign.center),
      ),
      onPressed: () {
        print(category.toString());
      },
    );
  }
}
