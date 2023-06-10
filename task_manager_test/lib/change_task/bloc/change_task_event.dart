part of 'change_task_bloc.dart';

@immutable
abstract class ChangeTaskEvent {}

class ChangeTaskButtonPressed extends ChangeTaskEvent {
  final int status;

  ChangeTaskButtonPressed(
      {
        required this.status});
}
