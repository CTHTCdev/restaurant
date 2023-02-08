part of 'home_bloc.dart';

abstract class HomeEvent {}

class InitHomeEvent extends HomeEvent{}

class TableName_HomeEvent extends HomeEvent{
  final String name;
  TableName_HomeEvent({required this.name});
}
