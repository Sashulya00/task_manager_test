part of 'task_list_bloc.dart';

@immutable
abstract class TaskListState {}

class InitialState extends TaskListState {}

class LoadingState extends TaskListState {}

class LoadedState extends TaskListState {
  LoadedState(this.taskList, this.selectedTab);
  final int selectedTab;
  final List<TaskModel> taskList;
}

class ErrorState extends TaskListState {
  ErrorState(this.error);
  final Object error;
}
