import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_test/data/model/task_model.dart';
import 'package:task_manager_test/data/repository/repository.dart';

part 'task_list_event.dart';
part 'task_list_state.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final Repository repository;

  List<TaskModel> filterTasks(
    List<TaskModel> allTasks,
    int selectedTab,
  ) =>
      switch (selectedTab) {
        1 || 2 => allTasks.where((task) => task.type == selectedTab).toList(),
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

          final allTasks = await repository.fetchTasks();
          final filteredTasks = filterTasks(allTasks, currentSelectedTab ?? 0);

          emit(
            LoadedState(
              allTasks: allTasks,
              filteredTasks: filteredTasks,
              selectedTab: currentSelectedTab ?? 0,
            ),
          );
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

          final allTasks = await repository.changeTask(
            event.taskId,
            event.isChecked,
          );
          final filteredTasks = filterTasks(allTasks, currentSelectedTab ?? 0);
          emit(
            LoadedState(
              allTasks: allTasks,
              filteredTasks: filteredTasks,
              selectedTab: currentSelectedTab ?? 0,
            ),
          );
        } catch (error) {
          emit(ErrorState(error));
        }
      },
    );

    on<TaskListTypeChanged>(
      (event, emit) async {
        List<TaskModel>? allTasks;
        if (state is LoadedState) {
          allTasks = (state as LoadedState).allTasks;
        }
        try {
          emit(LoadingState());

          allTasks ??= await repository.fetchTasks();
          final filteredTasks = filterTasks(allTasks, event.type);
          emit(
            LoadedState(
              allTasks: allTasks,
              filteredTasks: filteredTasks,
              selectedTab: event.type,
            ),
          );
        } catch (error) {
          emit(ErrorState(error));
        }
      },
    );

    on<LoadedTaskLostFromSecondsScreen>(
      (event, emit) async {
        try {
          int? currentSelectedTab;
          if (state is LoadedState) {
            currentSelectedTab = (state as LoadedState).selectedTab;
          }

          emit(LoadingState());

          final filteredTasks = filterTasks(
            event.list,
            currentSelectedTab ?? 0,
          );
          emit(
            LoadedState(
              allTasks: event.list,
              filteredTasks: filteredTasks,
              selectedTab: currentSelectedTab ?? 0,
            ),
          );
        } catch (error) {
          emit(ErrorState(error));
        }
      },
    );
  }
}
