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
