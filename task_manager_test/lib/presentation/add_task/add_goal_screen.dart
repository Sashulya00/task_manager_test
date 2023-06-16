import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_test/business_logic/bloc/add_task/add_task_bloc.dart';
import 'package:task_manager_test/data/model/task_model.dart';
import 'package:task_manager_test/data/repository/repository.dart';
import 'package:task_manager_test/presentation/tasks_screen/tasks_layout.dart';
import 'package:task_manager_test/presentation/widgets/background_widget.dart';
import 'package:task_manager_test/presentation/widgets/primary_button_widget.dart';
import 'package:task_manager_test/setup_service_locator.dart';

class AddGoalScreen extends StatelessWidget {
  const AddGoalScreen({super.key, this.model});

  final TaskModel? model;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddTaskBloc>(
      lazy: false,
      create: (_) => AddTaskBloc(serviceLocator<Repository>()),
      child: Builder(builder: (context) {
        return AddGoalLayout(
          model: model,
        );
      }),
    );
  }
}

class AddGoalLayout extends StatefulWidget {
  final TaskModel? model;

  const AddGoalLayout({super.key, this.model});

  @override
  State<AddGoalLayout> createState() => _AddGoalLayoutState();
}

class _AddGoalLayoutState extends State<AddGoalLayout> {
  static const datePickerTitle = 'Дата завершення:';
  int? type;
  DateTime? dateTime;
  bool isUrgent = false;
  XFile? pickedImagePath;
  final _nameController = TextEditingController();
  final _descController = TextEditingController();

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

  @override
  void initState() {
    super.initState();
    if (widget.model?.name != null) _nameController.text = widget.model!.name!;
    if (widget.model?.description != null) {
      _descController.text = widget.model!.description!;
    }

    isUrgent = widget.model?.urgent == 1;
    type = widget.model?.type;
    dateTime = widget.model?.finishDate;

    if (widget.model?.file != null && widget.model!.file!.isNotEmpty) {
      final image = base64Decode(widget.model!.file!);
      pickedImagePath = XFile.fromData(image);
    }
  }

  bool get isEditFlow => widget.model != null;

  Future<void> getImage() async {
    ImagePicker picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      pickedImagePath = pickedImage;
    });
  }

  Future<void> deleteTask(String taskId) async {
    return context.read<AddTaskBloc>().add(DeleteTaskButtonPressed(taskId));
  }

  Future<void> deleteImage() async {
    setState(() {
      pickedImagePath = null;
    });
  }

  void saveTask() async {
    final isValid = type != null &&
        _descController.text.isNotEmpty &&
        _nameController.text.isNotEmpty;
    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter valid data')),
      );
    } else {
      final imageBytes = await pickedImagePath?.readAsBytes();
      final encodedImage = imageBytes == null ? null : base64Encode(imageBytes);
      final event = isEditFlow
          ? UpdateTaskButtonPressed(
              taskId: widget.model!.taskId,
              name: _nameController.text,
              type: type!,
              isUrgent: isUrgent,
              desc: _descController.text,
              endDate: dateTime,
              photoEncoded: encodedImage,
            )
          : AddTaskButtonPressed(
              name: _nameController.text,
              type: type!,
              isUrgent: isUrgent,
              desc: _descController.text,
              endDate: dateTime,
              photoEncoded: encodedImage,
            );
      if (mounted) context.read<AddTaskBloc>().add(event);
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
                title: const Text('Робочі'),
                groupValue: type,
                onChanged: (value) => setState(() => type = value),
              ),
            ),
            Expanded(
              child: RadioListTile(
                value: 2,
                title: const Text('Особисті'),
                groupValue: type,
                onChanged: (value) => setState(() => type = value),
              ),
            ),
          ],
        ),
      );

  Widget get decription => yellowCard(
        TextFormField(
          controller: _descController,
          minLines: 3,
          maxLines: 3,
          decoration: const InputDecoration(
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
          title: const Text('Термінове'),
          onChanged: (value) => setState(() {
            isUrgent = value!;
          }),
        ),
      );

  Widget get file => GestureDetector(
        onTap: getImage,
        child: yellowCard(
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Прикріпити файл'),
                    if (pickedImagePath != null)
                      FutureBuilder(
                        future: pickedImagePath?.readAsBytes(),
                        builder: (context, snapshot) {
                          final isLoaded = snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData;

                          return SizedBox.square(
                            dimension: 200,
                            child: Center(
                              child: isLoaded
                                  ? Image.memory(snapshot.data!, height: 200)
                                  : const CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
              if (pickedImagePath != null)
                IconButton(
                  alignment: Alignment.centerRight,
                  onPressed: deleteImage,
                  icon: const Icon(
                    IconData(0xf645, fontFamily: 'MaterialIcons'),
                  ),
                ),
            ],
          ),
        ),
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

  Widget get nameWidget => isEditFlow
      ? Text(
          widget.model!.name!,
          style: const TextStyle(color: Colors.black),
        )
      : TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            hintText: 'Назва задачі',
            hintStyle: TextStyle(color: Colors.black),
          ),
        );

  Widget saveButton(BuildContext context) => yellowCard(
        PrimaryButtonWidget(
            buttonColor: primaryColor,
            buttonWidth: buttonWidth,
            buttonHeight: buttonHeight,
            buttonTitle: 'Створити',
            onPressed: saveTask),
      );

  Widget deleteButton(BuildContext context) => yellowCard(
        PrimaryButtonWidget(
          buttonColor: secondaryColor,
          buttonWidth: buttonWidth,
          buttonHeight: buttonHeight,
          buttonTitle: 'Видалити',
          onPressed: () {
            deleteTask(widget.model!.taskId);
            Navigator.pop(context);
          },
        ),
      );

  Widget get bottomButton =>
      isEditFlow ? deleteButton(context) : saveButton(context);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddTaskBloc, AddTaskState>(
      listener: (context, state) {
        if (state is AddTaskSuccess) Navigator.of(context).pop(true);
        if (state is AddTaskError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Error')));
        }
      },
      child: Stack(
        children: [
          const BackgroundWidget(),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: nameWidget,
              centerTitle: true,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.yellow,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              actions: !isEditFlow
                  ? null
                  : [
                      IconButton(
                        onPressed: saveTask,
                        icon: const Icon(Icons.check, color: Colors.yellow),
                      )
                    ],
            ),
            body: BlocBuilder<AddTaskBloc, AddTaskState>(
              builder: (context, state) {
                if (state is AddTaskLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      typeSelector,
                      decription,
                      file,
                      date,
                      important,
                      bottomButton,
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
