import 'package:flutter/material.dart';

class PrimaryButtonWidget extends StatelessWidget {
  const PrimaryButtonWidget({
    Key? key,
    required this.buttonColor,
    required this.buttonWidth,
    required this.buttonHeight,
    required this.onPressed,
    required this.buttonTitle,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Color buttonColor;
  final double buttonWidth;
  final double buttonHeight;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
        ),
        child: Text(
          buttonTitle,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
