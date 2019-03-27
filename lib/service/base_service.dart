import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BaseService {

  BuildContext context;
  GlobalKey<ScaffoldState> scaffoldKey;
  List<CancelToken> cancelTokenList = List();

  BaseService(this.context, this.scaffoldKey);

  void cancelAllHttpRequest() {
    for (CancelToken item in cancelTokenList) {
      item.cancel();
    }
  }

}