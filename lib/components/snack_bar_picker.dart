import 'package:flutter/material.dart';

class SnackBarPicker {


  static SnackBar success(String text) {
    return SnackBar(
      content: Text(text),
      backgroundColor: Colors.green,
    );
  }

  static SnackBar plain(String text) {
    return SnackBar(
      content: Text(text),
    );
  }

  static SnackBar error(String text) {
    return SnackBar(
      content: Text(text),
      backgroundColor: Colors.red,
    );
  }


}