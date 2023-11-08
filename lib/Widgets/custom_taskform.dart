// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class CustomTaskForm extends StatefulWidget {
  final controller;
  final String labelText;
  final int maxLines; // New parameter for defining the number of lines
  // New parameter to determine if it's a date/time field

  const CustomTaskForm({
    super.key,
    required this.controller,
    required this.labelText,
    this.maxLines = 2, // Default to 1 line if not provided
    // Default to a regular text field
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomTaskFormState createState() => _CustomTaskFormState();
}

class _CustomTaskFormState extends State<CustomTaskForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 4),
            child: Text(
              widget.labelText,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              color: Colors.orange,
              border: Border.all(color: Colors.deepOrange),
              borderRadius: BorderRadius.circular(12.0),
            ),
            alignment: Alignment.center,
            child: TextFormField(
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              textAlignVertical: TextAlignVertical.center,
              textInputAction: TextInputAction.newline,
              controller: widget.controller,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              maxLines: widget.maxLines,
            ),
          ),
        ],
      ),
    );
  }
}
