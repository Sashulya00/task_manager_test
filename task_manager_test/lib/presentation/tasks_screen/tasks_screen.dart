import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_test/business_logic/bloc/task_list_bloc.dart';
import 'package:task_manager_test/data/repository/repository.dart';
import 'package:task_manager_test/presentation/tasks_screen/tasks_layout.dart';
import 'package:task_manager_test/setup_service_locator.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  static const path = '/tasks_screen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskListBloc>.value(
      value: TaskListBloc(
        serviceLocator<Repository>(),
      ),
      child: const TasksLayout(),
    );
  }
}
