import 'package:agent/src/global/states/status.dart';
import 'package:agent/src/models/table.dart';
import 'package:agent/src/screens/table/table_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'table_event.dart';
part 'table_state.dart';

class TableBloc extends Bloc<TableEvent, TableState> {
  TableRepo _tableRepo = TableRepo.instance;
  TableBloc() : super(TableState());

  @override
  Stream<TableState> mapEventToState(TableEvent event) async* {
    if(event is Fetch_TableEvent){
      try {
        List<TableNow> tables = await _tableRepo.fetchTables();
        yield state.copyWith(status: StatusSucess(), tables: tables);
      } catch (e) {
        yield state.copyWith(status: StatusFailed(e: e));
      }
      
    }

  }
}
