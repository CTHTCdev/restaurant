import 'package:agent/src/global/services/graphql.dart';
import 'package:agent/src/models/category.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CategoryRepo {
  CategoryRepo._();
  static final CategoryRepo instance = CategoryRepo._();

  Future<List<CategoryNow>> fetchAllCategory() async {
    // return QueryResult from Future<>
    final QueryResult result = await GraphQlService.performQuery(
      document: FETCH_ALL_CATEGORY,
    );
    final categories = result.data?['category'];
    // print(categories);
    // Assign model
    if (categories.isNotEmpty) {
      return (categories as List)
          .map((category) => CategoryNow.fromMap(category))
          .toList();
    }
    return [];
  }

  static const String FETCH_ALL_CATEGORY = '''
    query ListCategory{
      category {
        id
        category_name
        category_lang1
        category_active
        category_type
      }
    }
    ''';
}
