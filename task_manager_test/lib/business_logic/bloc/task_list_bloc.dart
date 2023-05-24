import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_manager_test/data/model/task_model.dart';
import 'package:task_manager_test/data/repository/repository.dart';
part 'task_list_event.dart';
part 'task_list_state.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {

  // todo implement DI
  //final repo = RepositoryImpl(NetworkServiceImpl());
  final Repository repository;


  TaskListBloc(this.repository) : super(InitialState()) {
    on<LoadTaskList>((event, emit) async {
      final list =await repository.fetchTasks();
      print(list);

    });
  }
}
