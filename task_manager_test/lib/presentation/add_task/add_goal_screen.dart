import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
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
  DateTime? dateTime;
  bool isUrgent = false;
  static const datePickerTitle = 'Дата завершення:';
  XFile? pickedImagePath;

  Future<void> selectDate() async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialEntryMode: DatePickerEntryMode.calendar,
    );

    if (selectedDate != null) {
      setState(() {
        dateTime = selectedDate;
      });
    }
  }

  Future<void> getImage() async {
    ImagePicker picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      pickedImagePath = pickedImage;
    });
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
            onPressed: () async {
              if (type != null && desc != null && name != null) {
                List<int> imageBytes = await pickedImagePath!.readAsBytes();

                String base64Image = base64Encode(imageBytes);
                final event = AddTaskButtonPressed(
                  name: name!,
                  type: type!,
                  isUrgent: isUrgent,
                  desc: desc!,
                  photoEncoded: base64Image,
                  endDate: dateTime,
                );
                context.read<AddTaskBloc>().add(event);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Enter valid data')));
              }
            },
            buttonTitle: 'Створити'),
      );

  Widget get file => GestureDetector(
        onTap: getImage,
        child: yellowCard(Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Прикріпити файл'),
                  if (pickedImagePath != null)
                    Image.file(
                      File(pickedImagePath!.path),
                      height: 200,
                    ),
                ],
              ),
            ),
          ],
        )),
      );

  Widget get date {
    String? value;
    if (dateTime != null) value = DateFormat('yyyy-MM-dd').format(dateTime!);
    return GestureDetector(
      onTap: selectDate,
      child: yellowCard(Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('$datePickerTitle $value'),
          ),
        ],
      )),
    );
  }

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
