part of 'category_bloc.dart';

class CategoryState {
  final List<CategoryNow>? categories;
  final Status? status;
  CategoryState({
    this.categories,
    this.status,
  });

  CategoryState copyWith({
    List<CategoryNow>? categories,
    Status? status,
  }) {
    return CategoryState(
      categories: categories ?? this.categories,
      status: status ?? this.status,
    );
  }
}
