import 'package:agent/src/global/states/status.dart';
import 'package:agent/src/models/category.dart';
import 'package:agent/src/screens/category/category_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryRepo _categoryRepo = CategoryRepo.instance;
  CategoryBloc() : super(CategoryState());

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is Fetch_CategoryEvent) {
      try {
        List<CategoryNow> categories = await _categoryRepo.fetchAllCategory();
        yield state.copyWith(status: StatusSucess(), categories: categories);
      } catch (e) {
        yield state.copyWith(status: StatusFailed(e: e));
      }
    }
  }
}
