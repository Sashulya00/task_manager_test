import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_test/business_logic/bloc/task_list_bloc.dart';
import 'package:task_manager_test/data/model/task_model.dart';
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
const secondaryColor = Color(0xffFF8989);
const buttonWidth = 140.0;
const buttonHeight = 50.0;

class _TasksLayoutState extends State<TasksLayout> {
  @override
  void initState() {
    context.read<TaskListBloc>().add(LoadTaskList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: () async {
          final list = await Navigator.push<List<TaskModel>>(
            context,
            MaterialPageRoute(builder: (_) => const AddGoalScreen()),
          );
          if (mounted && list != null) {
            context.read<TaskListBloc>().add(
                  LoadedTaskLostFromSecondsScreen(list),
                );
          }
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
            buildWhen: (_, __) => true,
            builder: (context, state) {
              if (state is InitialState) {
                return const Center(child: Text("Waiting"));
              } else if (state is LoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ErrorState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(child: Text("error")),
                    Center(child: Text(state.error.toString())),
                    Center(
                      child: TextButton(
                        onPressed: () => context.read<TaskListBloc>().add(
                              LoadTaskList(),
                            ),
                        child: const Text('refresh'),
                      ),
                    ),
                  ],
                );
              } else if (state is LoadedState) {
                final list = state.filteredTasks;
                return Column(
                  children: [
                    SelectButtonWidget(
                      firstTabTitle: "Усі",
                      secondTabTitle: "Робочі",
                      thirdTabTitle: "Особисті",
                      selectedTab: state.selectedTab,
                      onChanged: (value) {
                        context.read<TaskListBloc>().add(
                              TaskListTypeChanged(value),
                            );
                      },
                    ),
                    Expanded(
                      child: ListView.separated(
                        key: Key(
                          list.fold<String>(
                              'ListKey', (p, e) => "$p ${e.taskId} "),
                        ),
                        separatorBuilder: (_, __) =>
                            const Divider(thickness: 4),
                        itemCount: (list.length),
                        itemBuilder: (_, index) {
                          final item = list[index];
                          return Center(
                            child: GestureDetector(
                              onTap: () async {
                                final list =
                                    await Navigator.push<List<TaskModel>>(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => AddGoalScreen(
                                      model: item,
                                    ),
                                  ),
                                );
                                if (mounted && list != null) {
                                  context.read<TaskListBloc>().add(
                                        LoadedTaskLostFromSecondsScreen(
                                          list,
                                        ),
                                      );
                                }
                              },
                              child: TaskWidget(
                                urgent: item.urgent!,
                                type: item.type!,
                                status: item.status!,
                                name: item.name!,
                                finishDate: item.finishDate.toString() ?? '',
                                onChecked: (value) =>
                                    context.read<TaskListBloc>().add(
                                          ChangeTaskButtonPressed(
                                            isChecked: value,
                                            taskId: item.taskId,
                                          ),
                                        ),
                              ),
                            ),
                          );
                        },
                      ),
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
