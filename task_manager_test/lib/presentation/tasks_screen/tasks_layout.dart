import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_test/business_logic/bloc/task_list_bloc.dart';
import 'package:task_manager_test/presentation/add_task/add_goal_screen.dart';
import 'package:task_manager_test/presentation/widgets/background_widget.dart';
import 'package:task_manager_test/presentation/widgets/select_button_widget.dart';
import 'package:task_manager_test/presentation/widgets/task_widget.dart';

class TasksLayout extends StatefulWidget {
  const TasksLayout({Key? key}) : super(key: key);

  @override
  State<TasksLayout> createState() => _TasksLayoutState();
}

const primaryColor = Color(0xffffd600);
const buttonWidth = 140.0;
const buttonHeight = 50.0;

class _TasksLayoutState extends State<TasksLayout> {

  @override
  void initState() {
    context.read<TaskListBloc>().add(LoadTaskList());
    super.initState();
  }

  var selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddGoalScreen()),
          );
          if (mounted) context.read<TaskListBloc>().add(LoadTaskList());
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      body: Stack(
        children: [
          const BackgroundWidget(),
          BlocBuilder<TaskListBloc, TaskListState>(
            builder: (context, state) {
              if (state is InitialState) {
                return const Center(child: Text("Waiting"));
              } else if (state is LoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ErrorState) {
                return const Center(child: Text("error"));
              } else if (state is LoadedState) {
                var list = state.taskList;
                if (selectedTab != 0) {
                  list = list
                      .where(
                        (task) => task.type == selectedTab,
                      )
                      .toList();
                }

                return Stack(
                  children: [
                    Text(list.length.toString()),
                    Column(
                      children: [
                        SelectButtonWidget(
                          firstTabTitle: "Усі",
                          secondTabTitle: "Робочі",
                          thirdTabTitle: "Особисті",
                          selectedTab: selectedTab,
                          onChanged: (value) => setState(() => selectedTab = value),
                        ),
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (_, __) => const Divider(thickness: 4),
                            itemCount: (list.length),
                            itemBuilder: (_, index) {
                              final item = list[index];
                              return Center(
                                child: TaskWidget(
                                  urgent: item.urgent!,
                                  type: item.type!,
                                  status: item.status!,
                                  name: item.name!,
                                  finishDate: item.finishDate.toString() ?? '',
                                  onChecked: (value) => context.read<TaskListBloc>().add(
                                        ChangeTaskButtonPressed(
                                          isChecked: value,
                                          taskId: item.taskId,
                                        ),
                                      ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                throw Exception('unprocessed state $state in TasksLayout');
              }
            },
          ),
        ],
      ),
    );
  }
}
