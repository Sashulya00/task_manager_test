import 'package:flutter/material.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    super.key,
    required this.urgent,
    required this.type,
    required this.status,
    required this.name,
    required this.finishDate,
    required this.onChecked,
  });

  final int urgent;
  final int type;
  final int status;
  final String name;
  final String finishDate;
  final void Function(bool) onChecked;
  static const space = SizedBox(height: 5);
  static const enabledColor = Color(0xffFBEFB4);
  static const urgentColor = Color(0xffFF8989);
  static const disabledColor = Color(0xffDBDBDB);
  static const paddingHorizontal = EdgeInsets.symmetric(horizontal: 8.0);
  static const workIcon = Icon(
    IconData(0xe6f4, fontFamily: 'MaterialIcons'),
  );
  static const homeIcon = Icon(
    IconData(0xf107, fontFamily: 'MaterialIcons'),
  );

  Icon getTypeIcon(int value) {
    if (value == 1) {
      return workIcon;
    } else if (value == 2) {
      return homeIcon;
    }
    throw Exception('Unknown icon');
  }

  Color getUrgentColor(int value) {
    if (value == 0) {
      return disabledColor;
    } else if (value == 1) {
      return urgentColor;
    }
    throw Exception('Unknown color');
  }

  @override
  Widget build(BuildContext context) {
    late final bool isChecked;
    if (status == 2) {
      isChecked = true;
    } else if (status == 1) {
      isChecked = false;
    } else {
      throw Exception('Unknown status');
    }
    return Stack(
      children: [
        Container(
          width: 350,
          height: 65,
          decoration: BoxDecoration(
            color: getUrgentColor(urgent), //urgent
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
                  child: getTypeIcon(type),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    space,
                    Container(
                      width: 240,
                      height: 40,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          name, //name
                          softWrap: true,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          finishDate, //finishDate
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
                        onChecked(value!);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
