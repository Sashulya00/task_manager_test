import 'package:flutter/material.dart';
import 'package:task_manager_test/presentation/tasks_screen/tasks_layout.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  static const path = '/tasks_screen';

  @override
  Widget build(BuildContext context) {
    return const TasksLayout();
  }
}
