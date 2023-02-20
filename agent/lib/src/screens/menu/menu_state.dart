part of 'menu_bloc.dart';

class MenuState {
  final List<MenuNow>? menus;
  final Status? status;

  MenuState({
    this.menus,
    this.status,
  });

  MenuState copyWith({
    List<MenuNow>? menus,
    Status? status,
  }) {
    return MenuState(
      menus: menus ?? this.menus,
      status: status ?? this.status,
    );
  }
}
