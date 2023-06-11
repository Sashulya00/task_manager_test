import 'package:flutter/material.dart';
import 'package:task_manager_test/data/repository/repository_impl.dart';
import 'package:task_manager_test/data/services/network_services_impl.dart';
import 'package:task_manager_test/presentation/tasks_screen/tasks_screen.dart';
import 'package:task_manager_test/presentation/widgets/background_widget.dart';
import 'package:task_manager_test/presentation/widgets/primary_button_widget.dart';

class GreetingLayout extends StatefulWidget {
  const GreetingLayout({super.key});

  @override
  State<GreetingLayout> createState() => _GreetingLayoutState();
}

class _GreetingLayoutState extends State<GreetingLayout> {
  static const buttonWidth = 140.0;
  static const buttonHeight = 50.0;
  static const buttonTitle = "Вхід";
  static const primaryColor = Color(0xffffd600);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundWidget(),
          Center(
            child: PrimaryButtonWidget(
              buttonTitle: buttonTitle,
              buttonWidth: buttonWidth,
              buttonColor: primaryColor,
              buttonHeight: buttonHeight,
              onPressed: () {
                Navigator.of(context).pushNamed(TasksScreen.path);
              },
            ),
          )
        ],
      ),
    );
  }
}
