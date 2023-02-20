import 'package:agent/src/global/services/graphql.dart';
import 'package:agent/src/models/menu.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MenuRepo {
  MenuRepo._();
  static final MenuRepo instance = MenuRepo._();

  Future<List<MenuNow>> fetchAllMenu() async {
    // return QueryResult from Future<>
    final QueryResult result = await GraphQlService.performQuery(
      document: FETCH_ALL_Menu,
    );
    final menus = result.data?['menu'];
    print(menus);
    // Assign model
    if (menus.isNotEmpty) {
      return (menus as List).map((menu) => MenuNow.fromMap(menu)).toList();
    }
    return [];
  }

  static const String FETCH_ALL_Menu = '''
    query ListMenu{
      menu {
        id
        menu_code
        menu_name
        menu_lang1
        menu_price
        menu_active
        menu_colour
      }
    }
    ''';
}
