import 'dart:io';

import 'package:agent/src/global/states/status.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if(event is TableName_HomeEvent) {
      // print(event.name);
      try {
        yield state.copyWith(status: StatusSucess());
        yield state.copyWith(name: event.name);
      } catch (e) {
        yield state.copyWith(status: StatusFailed(e: e));
      }
      
    }
  }

  
}
