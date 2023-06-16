import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_test/data/model/task_model.dart';
import 'package:task_manager_test/data/repository/repository.dart';

part 'add_task_event.dart';
part 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  final Repository repository;

  AddTaskBloc(this.repository) : super(AddTaskInitial()) {
    on<AddTaskButtonPressed>(
      (event, emit) async {
        try {
          emit(AddTaskLoading());
          final model = TaskModel(
            id: Random().nextInt(10000).toString(),
            taskId: Random().nextInt(10000).toString(),
            status: 1,
            name: event.name,
            type: event.type,
            description: event.desc,
            file: event.photoEncoded,
            finishDate: event.endDate,
            urgent: event.isUrgent ? 1 : 0,
            syncTime: DateTime.now(),
          );
          final list = await repository.addTask(model);
          emit(AddTaskSuccess(list));
        } catch (error) {
          emit(AddTaskError());
          rethrow;
        }
      },
    );
    on<UpdateTaskButtonPressed>(
      (event, emit) async {
        try {
          emit(AddTaskLoading());
          final model = TaskModel(
            id: Random().nextInt(10000).toString(),
            taskId: event.taskId,
            status: 1,
            name: event.name,
            type: event.type,
            description: event.desc,
            file: event.photoEncoded,
            finishDate: event.endDate,
            urgent: event.isUrgent ? 1 : 0,
            syncTime: DateTime.now(),
          );
          final list = await repository.addTask(model);
          emit(AddTaskSuccess(list));
        } catch (error) {
          emit(AddTaskError());
          rethrow;
        }
      },
    );
    on<DeleteTaskButtonPressed>(
      (event, emit) async {
        try {
          emit(AddTaskLoading());
          final list = await repository.deleteTask(event.taskId);
          emit(AddTaskSuccess(list));
        } catch (error) {
          emit(AddTaskError());
          rethrow;
        }
      },
    );
  }
}
