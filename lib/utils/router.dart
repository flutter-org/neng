import 'package:flutter/material.dart';

class Router {

  static Future<String> push(BuildContext context, Widget page) {
    return Navigator.of(context).push<String>(MaterialPageRoute(builder: (context) => page));
  }

  static push2(BuildContext context, Widget page) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => page),
        (route) => route == null
    );
  }

}