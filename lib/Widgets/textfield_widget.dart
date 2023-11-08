import 'package:flutter/material.dart';

class CustomInputDecoration extends InputDecoration {
  CustomInputDecoration({
    String labelText = '',
    Color fillColor = Colors.white30,
    Color labelColor = Colors.black,
    Color borderColor = Colors.blueGrey,
    Color focusedBorderColor = Colors.green,
    Color enabledBorderColor = Colors.greenAccent,
    Color errorBorderColor = Colors.red,
  }) : super(
          filled: true,
          fillColor: fillColor,
          labelText: labelText,
          labelStyle: TextStyle(color: labelColor),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: focusedBorderColor, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: enabledBorderColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: errorBorderColor, width: 2),
          ),
        );
}
