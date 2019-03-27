import 'package:flutter/material.dart';
import 'package:neng/components/top_reminder_picker.dart';

class Push {

  static void pushTopReminder(BuildContext context,
      String text) {
    Navigator.of(context).push(
      PageRouteBuilder(
          // 转换完成后路由是否会遮盖以前的路由。
          opaque: false,
          // 页面构建器（`pageBuilder`）属性，用于构建路径的主要内容。
          pageBuilder: (BuildContext context, _, __) {
            return TopReminderPicker(reminderText: text);
          },
          transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
            // 淡出过渡（`FadeTransition`）组件，动画组件的不透明度。
            // https://docs.flutter.io/flutter/widgets/FadeTransition-class.html
            return FadeTransition(
              // 不透明度（`opacity`）属性，控制子组件不透明度的动画。
              opacity: animation,
              // 滑动过渡（`SlideTransition`）组件，动画组件相对于其正常位置的位置。
              // https://docs.flutter.io/flutter/widgets/SlideTransition-class.html
              child: SlideTransition(
                // 位置（`position`）属性，控制子组件位置的动画。
                // 两者之间（`Tween`）类，开始值和结束值之间的线性插值。
                // 偏移（`Offset`）类，不可变的2D浮点偏移量。
                position: Tween<Offset>(
                  // 两者之间（`Tween`）类的开始（`begin`）属性，此变量在动画开头的值。
                  begin: Offset(0.0, -0.3),
                  // 两者之间（`Tween`）类的结束（`end`）属性，此变量在动画结束时的值。
                  end: Offset.zero,
                  // 两者之间（`Tween`）类的活跃（`animate`）方法，返回由给定动画驱动但接受由此对象确定的值的新动画。
                ).animate(animation),
                child: child,
              ),
            );
          }
      ),
    );
  }

}