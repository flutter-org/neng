import 'package:flutter/material.dart';
import 'package:neng/components/loading_picker.dart';
import 'package:neng/utils/global.dart';

class Load {

  static void openLoading(BuildContext mainContext) {
    showDialog<Null>(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          GlobalConfig.loadingContext = context;
          return LoadingPicker();
        }
     );
  }

  static void closeLoading() {
    if (null == GlobalConfig.loadingContext) {
      return;
    }
    Navigator.pop(GlobalConfig.loadingContext);
    GlobalConfig.loadingContext = null;
  }

}