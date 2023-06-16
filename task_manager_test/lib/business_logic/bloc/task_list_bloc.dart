import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:task_manager_test/data/model/task_model.dart';
import 'package:task_manager_test/data/repository/repository.dart';

part 'task_list_event.dart';
part 'task_list_state.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final Repository repository;

  List<TaskModel> filterTasks(List<TaskModel> allTasks, int selectedTab) =>
      switch (selectedTab) {
        1 => allTasks.where((task) => task.type == 1).toList(),
        2 => allTasks.where((task) => task.type == 2).toList(),
        _ => allTasks,
      };

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
