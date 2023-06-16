part of 'add_task_bloc.dart';

@immutable
abstract class AddTaskEvent {}

class AddTaskButtonPressed extends AddTaskEvent {
  final String name;
  final int type;
  final bool isUrgent;
  final String desc;
  final String? photoEncoded;
  final DateTime? endDate;

  AddTaskButtonPressed({
    required this.name,
    required this.type,
    required this.isUrgent,
    required this.desc,
    this.photoEncoded,
    this.endDate,
  });
}

class UpdateTaskButtonPressed extends AddTaskEvent {
  final String taskId;
  final String name;
  final int type;
  final bool isUrgent;
  final String desc;
  final String? photoEncoded;
  final DateTime? endDate;

  UpdateTaskButtonPressed({
    required this.taskId,
    required this.name,
    required this.type,
    required this.isUrgent,
    required this.desc,
    this.photoEncoded,
    this.endDate,
  });
}

class DeleteTaskButtonPressed extends AddTaskEvent {
  final String taskId;

  DeleteTaskButtonPressed(this.taskId);
}

class DeleteImageButtonPressed extends AddTaskEvent {
  final TaskModel model;

  DeleteImageButtonPressed(this.model);
}
