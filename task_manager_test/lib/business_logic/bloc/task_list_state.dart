part of 'task_list_bloc.dart';

@immutable
abstract class TaskListState {}

class InitialState extends TaskListState {}

class LoadingState extends TaskListState {}

class LoadedState extends TaskListState {
  LoadedState({
    required this.allTasks,
    required this.selectedTab,
    required this.filteredTasks,
  });

  final int selectedTab;
  final List<TaskModel> allTasks;
  final List<TaskModel> filteredTasks;
}

class ErrorState extends TaskListState {
  ErrorState(this.error);

  final Object error;
}
