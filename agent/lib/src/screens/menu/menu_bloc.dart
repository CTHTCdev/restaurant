import 'package:agent/src/global/states/status.dart';
import 'package:agent/src/models/menu.dart';
import 'package:agent/src/screens/menu/menu_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuRepo _menuRepo = MenuRepo.instance;
  MenuBloc() : super(MenuState());

  @override
  Stream<MenuState> mapEventToState(MenuEvent event) async* {
    if (event is Fetch_MenuEvent) {
      try {
        List<MenuNow> menus = await _menuRepo.fetchAllMenu();
        yield state.copyWith(status: StatusSucess(), menus: menus);
      } catch (e) {
        yield state.copyWith(status: StatusFailed(e: e));
      }
    }
  }
}
