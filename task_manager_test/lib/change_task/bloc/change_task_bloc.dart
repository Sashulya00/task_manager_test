
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_manager_test/data/repository/repository.dart';

part 'change_task_event.dart';
part 'change_task_state.dart';

class ChangeTaskBloc extends Bloc<ChangeTaskEvent, ChangeTaskState> {
  final Repository repository;
  ChangeTaskBloc(this.repository) : super(ChangeTaskInitial()) {
    on<ChangeTaskEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
