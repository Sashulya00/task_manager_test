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
    on<AddTaskButtonPressed>((event, emit) async {
      try {
        emit(AddTaskLoading());
        final model = TaskModel(
          id: Random().nextInt(10000).toString(),
          taskId: Random().nextInt(10000).toString(),
          status: 1,
          name: event.name,
          type: event.type,
          description: event.desc,
          file: 'null',
          finishDate: event.endDate,
          urgent: event.isUrgent ? 0 : 1,
          syncTime: DateTime.now(),
        );
        await repository.addTask(model);
        emit(AddTaskSuccess());
      } catch (error) {
        emit(AddTaskError());
      }
    });
  }
}
