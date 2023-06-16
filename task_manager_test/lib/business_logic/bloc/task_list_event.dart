part of 'task_list_bloc.dart';

@immutable
abstract class TaskListEvent {}

class LoadTaskList extends TaskListEvent {}

class ChangeTaskButtonPressed extends TaskListEvent {
  final bool isChecked;
  final String taskId;

  ChangeTaskButtonPressed({
    required this.isChecked,
    required this.taskId,
  });
}

class TaskListTypeChanged extends TaskListEvent {
  final int type;

  TaskListTypeChanged(this.type);
}
