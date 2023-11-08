// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final Color iconColor;
  final Function onPressed;

  const CustomIconButton({
    super.key,
    required this.icon,
    this.iconSize = 24.0,
    this.iconColor = Colors.black,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed(); // Call the onPressed function when tapped
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromARGB(0, 46, 43, 43),
        ),
        child: Icon(
          icon,
          size: iconSize,
          color: iconColor,
        ),
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color buttonColor;
  final double buttonWidth;
  final double buttonHeight;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.buttonColor, // Default button color
    this.buttonWidth = 200, // Default button width
    this.buttonHeight = 50, // Default button height
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: buttonColor,
        minimumSize: Size(buttonWidth, buttonHeight),
      ),
      child: Text(text),
    );
  }
}
