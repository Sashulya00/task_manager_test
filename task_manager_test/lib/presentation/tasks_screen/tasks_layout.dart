import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_test/business_logic/bloc/task_list_bloc.dart';
import 'package:task_manager_test/presentation/widgets/background_widget.dart';
import 'package:task_manager_test/presentation/widgets/select_button_widget.dart';
import 'package:task_manager_test/presentation/widgets/task_widget.dart';

class TasksLayout extends StatefulWidget {
  const TasksLayout({Key? key}) : super(key: key);

  @override
  State<TasksLayout> createState() => _TasksLayoutState();
}

class _TasksLayoutState extends State<TasksLayout> {
  @override
  void initState() {
    context.read<TaskListBloc>().add(LoadTaskList());
    super.initState();
  }

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                if (selectedTab != 0) list = list.where((task) => task.type == selectedTab).toList();

                return Stack(
                  children: [
                    Text(list.length.toString()),
                    Column(
                      children: [
                        SelectButtonWidget(
                          firstTabTitle: "Усі",
                          secondTabTitle: "Робочі",
                          thirdTabTitle: "Особисті",
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
                                  finishDate: item.finishDate ?? '',
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
// ListView(
// children: [
// Stack(
// children: [BackgroundWidget(),
// Column(
// children: [
// Center(
// child:
// ),
// TaskWidget(urgent: , type: null, status: null, name: '', finishDate: null,),
// ],
// ),
// ],
// ),
// ]
// ,
// )
// ,
