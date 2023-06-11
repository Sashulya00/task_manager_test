import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_test/business_logic/bloc/add_task/add_task_bloc.dart';
import 'package:task_manager_test/data/repository/repository.dart';
import 'package:task_manager_test/presentation/tasks_screen/tasks_layout.dart';
import 'package:task_manager_test/presentation/widgets/background_widget.dart';
import 'package:task_manager_test/presentation/widgets/primary_button_widget.dart';
import 'package:task_manager_test/setup_service_locator.dart';

class AddGoalScreen extends StatelessWidget {
  const AddGoalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddTaskBloc>(
      lazy: false,
      create: (_) => AddTaskBloc(serviceLocator<Repository>()),
      child: Builder(builder: (context) {
        return const AddGoalLayout();
      }),
    );
  }
}

class AddGoalLayout extends StatefulWidget {
  const AddGoalLayout({Key? key}) : super(key: key);

  @override
  State<AddGoalLayout> createState() => _AddGoalLayoutState();
}

class _AddGoalLayoutState extends State<AddGoalLayout> {
  int? type;
  String? name;
  String? desc;
  String? filePath;
  DateTime? dateTime;
  bool isUrgent = false;
  final datePickerController = TextEditingController();
  static const datePickerTitle = 'Дата завершення:';

  Future<void> selectDate() async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialEntryMode: DatePickerEntryMode.calendar,
    );

    if (selectedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      setState(() {
        datePickerController.text = formattedDate.toString();
      });
    }
  }

  Widget yellowCard(Widget child) => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.yellow[100],
          ),
          child: child,
        ),
      );

  Widget get typeSelector => yellowCard(
        Row(
          children: [
            Expanded(
              child: RadioListTile(
                value: 1,
                title: Text('Робочі'),
                groupValue: type,
                onChanged: (value) => setState(() => type = value),
              ),
            ),
            Expanded(
              child: RadioListTile(
                value: 2,
                title: Text('Особисті'),
                groupValue: type,
                onChanged: (value) => setState(() => type = value),
              ),
            ),
          ],
        ),
      );

  Widget get decription => yellowCard(
        TextFormField(
          minLines: 3,
          maxLines: 3,
          onChanged: (value) {
            desc = value;
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(20),
            hintText: 'Додати опис...',
            hintStyle: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      );

  Widget get important => yellowCard(
        CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          value: isUrgent,
          title: Text('Термінове'),
          onChanged: (value) => setState(() {
            isUrgent = value!;
          }),
        ),
      );

  Widget saveButton(BuildContext context) => yellowCard(
        PrimaryButtonWidget(
            buttonColor: primaryColor,
            buttonWidth: buttonWidth,
            buttonHeight: buttonHeight,
            onPressed: () {
              if (type != null && desc != null && name != null) {
                final event = AddTaskButtonPressed(name: 'name', type: type!, isUrgent: isUrgent, desc: desc!);
                context.read<AddTaskBloc>().add(event);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error')));
              }
            },
            buttonTitle: 'Створити'),
      );

  Widget get file => yellowCard(Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Прикріпити файл'),
          ),
        ],
      ));

  Widget get date => GestureDetector(onTap: selectDate,
    child: yellowCard(Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('$datePickerTitle ${datePickerController.text}'),
            ),
          ],
        )),
  );

  Widget get nameWidget => TextFormField(
        onChanged: (value) => setState(() {
          name = value;
        }),
        decoration: InputDecoration(
          hintText: 'Назва задачі',
          hintStyle: TextStyle(color: Colors.black),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddTaskBloc, AddTaskState>(
      listener: (context, state) {
        if (state is AddTaskSuccess) Navigator.of(context).pop(true);
        if (state is AddTaskError) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error')));
      },
      child: Stack(
        children: [
          BackgroundWidget(),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: nameWidget,
              centerTitle: true,
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.yellow,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: BlocBuilder<AddTaskBloc, AddTaskState>(
              builder: (context, state) {
                if (state is AddTaskLoading) return Center(child: CircularProgressIndicator());
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      typeSelector,
                      decription,
                      file,
                      date,
                      important,
                      saveButton(context),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
