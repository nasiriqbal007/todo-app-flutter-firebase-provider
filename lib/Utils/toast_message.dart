import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class ToastService {
  void showToast(String message, Duration duration, ToastGravity gravity) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.amber[600],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
