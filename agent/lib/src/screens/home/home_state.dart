part of 'home_bloc.dart';


class HomeState {
  final String name;
  final Status status;

  HomeState({this.name = '', this.status= const StatusInitial()});

  HomeState copyWith({
    String? name,
    Status? status,
  }) {
    return HomeState(name: name ?? this.name, status: status ?? this.status);
  }

  
}
