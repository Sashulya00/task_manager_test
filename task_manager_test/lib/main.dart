import 'package:flutter/material.dart';
import 'package:task_manager_test/presentation/greeting_screen/greeting_screen.dart';
import 'package:task_manager_test/presentation/tasks_screen/tasks_screen.dart';

void main() {

  // TODO(Sanya): move material app to the another file

  runApp(
    MaterialApp(
      home: const GreetingScreen(),
      builder: (_, screen) => SafeArea(child: screen!),
      routes: <String, WidgetBuilder>{
        TasksScreen.path: (BuildContext context) => const TasksScreen(),
      },
    ),
  );
}
