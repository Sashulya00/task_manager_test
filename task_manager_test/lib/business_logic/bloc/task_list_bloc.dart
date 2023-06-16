import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
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
          emit(LoadedState(list, 0));
        } catch (error) {
          emit(ErrorState(error));
        }
      },
    );

    on<ChangeTaskButtonPressed>(
      (event, emit) async {
        try {
          emit(LoadingState());

          await repository.changeTask(
            event.taskId,
            event.isChecked,
          );
          final list = await repository.fetchTasks();
          emit(LoadedState(list, 0));
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

          if (event.type == 0) {
            emit(LoadedState(allTasks, 0));
          } else if (event.type == 1) {
            final result = allTasks
                .where(
                  (task) => task.type == 1,
                )
                .toList();
            final workTasks = result.toList();
            emit(LoadedState(workTasks, 1));
          } else if (event.type == 2) {
            final result = allTasks
                .where(
                  (task) => task.type == 2,
                )
                .toList();
            final personalTasks = result.toList();
            emit(LoadedState(personalTasks, 2));
          }
        } catch (error) {
          emit(ErrorState(error));
        }
      },
    );
  }
}
