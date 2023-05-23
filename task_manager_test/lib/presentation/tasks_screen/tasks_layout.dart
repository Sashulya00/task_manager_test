import 'package:flutter/material.dart';
import 'package:task_manager_test/presentation/widgets/background_widget.dart';

class TasksLayout extends StatelessWidget {
  const TasksLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundWidget(),
          Center(
          )
        ],
      ),
    );
  }
}
