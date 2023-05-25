import 'package:flutter/material.dart';

class TabWidget extends StatelessWidget {
  TabWidget({
    super.key,
    required this.tabsTitle,
    required this.customWidth,
    required this.customColor,
    required this.onChanged,
  });

  final String tabsTitle;
  final double customWidth;
  final Color customColor;
  final VoidCallback onChanged;

  static const fontSize = 16.0;
  static const buttonHeight = 48.0;
  final circularRadius = BorderRadius.circular(40.0);
  static const duration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged,
      child: Tab(
        child: AnimatedContainer(
          width: customWidth,
          height: buttonHeight,
          duration: duration,
          decoration: BoxDecoration(
            color: customColor,
            borderRadius: circularRadius,
          ),
          child: Center(
            child: Text(
              tabsTitle,
              style: const TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
