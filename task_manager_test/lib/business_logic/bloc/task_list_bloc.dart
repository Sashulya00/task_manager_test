import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_manager_test/data/model/task_model.dart';
import 'package:task_manager_test/data/repository/repository.dart';

part 'task_list_event.dart';

part 'task_list_state.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final Repository repository;

  TaskListBloc(this.repository) : super(InitialState()) {
    on<LoadTaskList>(
      (event, emit) async {
        try {
          emit(LoadingState());

          final list = await repository.fetchTasks();
          emit(LoadedState(list));
        } catch (error) {
          emit(ErrorState(error));
        }
      },
    );

    on<ChangeTaskButtonPressed>(
      (event, emit) async {
        try {
          emit(LoadingState());

          await repository.changeTask(event.taskId, event.isChecked);
          final list = await repository.fetchTasks();
          emit(LoadedState(list));
        } catch (error) {
          emit(ErrorState(error));
        }
      },
    );
  }
}
