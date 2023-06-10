part of 'change_task_bloc.dart';

@immutable
abstract class ChangeTaskState {}

class ChangeTaskInitial extends ChangeTaskState {}

class ChangeTaskLoading extends ChangeTaskState {}
class ChangeTaskError extends ChangeTaskState {}
class ChangeTaskSuccess extends ChangeTaskState {}