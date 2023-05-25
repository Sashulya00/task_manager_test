import 'package:flutter/material.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({
    super.key,
    required this.urgent,
    required this.type,
    required this.status,
    required this.name,
    required this.finishDate,
  });
  final int urgent;
  final int type;
  final int status;
  final String name;
  final String finishDate;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  static const space = SizedBox(height: 5);
  static const enabledColor = Color(0xffFBEFB4);
  static const paddingHorizontal = EdgeInsets.symmetric(horizontal: 8.0);
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: 350,
        height: 65,
        decoration: BoxDecoration(
          color: const Color(0xffFF8989),//urgent
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: paddingHorizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 45,
                height: 45,
                child: const Icon(
                  IconData(0xe6f4, fontFamily: 'MaterialIcons'),//type
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  space,
                  Container(
                    width: 240,
                    height: 40,
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Намалювати головну сторінку цієї програми',//name
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child:  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'DD.MM.YEAR',//finishDate
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: 45,
                height: 45,
                child: Transform.scale(
                  scale: 2,
                  child: Checkbox(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      value: isChecked,
                      checkColor: Colors.black,
                      activeColor: enabledColor,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
