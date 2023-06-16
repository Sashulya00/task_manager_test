import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:task_manager_test/data/model/task_model.dart';
import 'package:task_manager_test/data/repository/repository.dart';

part 'task_list_event.dart';
part 'task_list_state.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final Repository repository;

  List<TaskModel> filterTasks(List<TaskModel> allTasks, int selectedTab) {
    if (selectedTab == 0) {
      return allTasks;
    } else if (selectedTab == 1) {
      final result = allTasks
          .where(
            (task) => task.type == 1,
          )
          .toList();
      final workTasks = result.toList();
      return workTasks;
    } else if (selectedTab == 2) {
      final result = allTasks
          .where(
            (task) => task.type == 2,
          )
          .toList();
      final personalTasks = result.toList();
      return personalTasks;
    }
    throw Exception('Unhandled selectedTab in filterTasks');
  }

  TaskListBloc(this.repository) : super(InitialState()) {
    on<LoadTaskList>(
      (event, emit) async {
        try {
          int? currentSelectedTab;
          if (state is LoadedState) {
            currentSelectedTab = (state as LoadedState).selectedTab;
          }

          emit(LoadingState());

          final list = await repository.fetchTasks();
          final filteredTasks = filterTasks(list, currentSelectedTab ?? 0);
          emit(LoadedState(filteredTasks, currentSelectedTab ?? 0));
        } catch (error) {
          emit(ErrorState(error));
        }
      },
    );

    on<ChangeTaskButtonPressed>(
      (event, emit) async {
        try {
          int? currentSelectedTab;
          if (state is LoadedState) {
            currentSelectedTab = (state as LoadedState).selectedTab;
          }

          emit(LoadingState());

          await repository.changeTask(
            event.taskId,
            event.isChecked,
          );
          final list = await repository.fetchTasks();
          final filteredTasks = filterTasks(list, currentSelectedTab ?? 0);
          emit(LoadedState(filteredTasks, currentSelectedTab ?? 0));
        } catch (error) {
          emit(ErrorState(error));
        }
      },
    );

    on<TaskListTypeChanged>(
      (event, emit) async {
        try {
          emit(LoadingState());

          final allTasks = await repository.fetchTasks();
          final filteredTasks = filterTasks(allTasks, event.type);
          emit(LoadedState(filteredTasks, event.type));
        } catch (error) {
          emit(ErrorState(error));
        }
      },
    );
  }
}
