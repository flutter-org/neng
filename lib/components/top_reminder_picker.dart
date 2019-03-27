import 'dart:async';
import 'package:flutter/material.dart';

class TopReminderPicker extends StatefulWidget {
  final String reminderText;

  TopReminderPicker({
    @required this.reminderText,
  });

  @override
  _TopReminderPickerState createState() => _TopReminderPickerState();
}

class _TopReminderPickerState extends State<TopReminderPicker> {

  Timer _timer;
  double _height = 110.0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  _startTimer() {
    _timer = Timer(
      // 持续时间参数。
      Duration(seconds: 2),
      // 回调函数参数。
          () {
        Navigator.of(context).pop(true);
      },
    );
  }

  void _cancelTimer() {
    // 计时器（`Timer`）组件的取消（`cancel`）方法，取消计时器。
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          child: Stack(
            children: <Widget>[
              Opacity(
                opacity: 1.0,
                child: Container(
                  height: _height,
                  color: Colors.white,
                ),
              ),
              Positioned(
                left: 20.0,
                right: 20.0,
                top: 20.0,
                child: Container(
                  height: _height,
                  width: 500.0,
                  child: Center(
                      child: Text(
                        widget.reminderText,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                        ),
                      )
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}