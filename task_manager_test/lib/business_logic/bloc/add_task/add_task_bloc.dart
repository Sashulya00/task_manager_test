import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
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
          await repository.addTask(model);
          emit(AddTaskSuccess());
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
          await repository.addTask(model);
          emit(AddTaskSuccess());
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
          await repository.deleteTask(event.taskId);
          emit(AddTaskSuccess());
        } catch (error) {
          emit(AddTaskError());
          rethrow;
        }
      },
    );
    on<DeleteImageButtonPressed>(
      (event, emit) async {
        try {
          emit(AddTaskLoading());
          await repository.addTask(event.model.copyWithoutImage());
          emit(AddTaskSuccess());
        } catch (error) {
          emit(AddTaskError());
          rethrow;
        }
      },
    );
  }
}
