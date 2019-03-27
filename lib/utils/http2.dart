import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:neng/components/snack_bar_picker.dart';
import 'package:neng/main.dart';
import 'package:neng/model/base.dart';
import 'package:neng/utils/global.dart';
import 'package:neng/utils/router.dart';
import 'package:neng/utils/shared_preferences2.dart';

class Http2 {

  static Future<String> get(String url, Object obj, {CancelToken cancelToken}) async {
    Dio dio = new Dio();
    dio.options.connectTimeout = 10000;
    if(null != GlobalConfig.token){
      dio.options.headers = {"Authorization": GlobalConfig.token};
    }
    Response response = await dio.get(url, data: obj, cancelToken: cancelToken, options: Options(
      data: obj
    ));

    print('http request：${url}, ${response.data}');
    String res = json.encode(response.data).toString();
    return res;
  }

  static Future<String> postJson(String url, Object obj, {CancelToken cancelToken}) async {
    Dio dio = new Dio();
    dio.options.connectTimeout = 10000;
    if(null != GlobalConfig.token){
      dio.options.headers = {"Authorization": GlobalConfig.token};
    }
    Response response = await dio.post(url, data: obj, cancelToken: cancelToken, options: Options(
      data: obj
    ));

    print('http request：${url}, ${response.data}');
    String res = json.encode(response.data).toString();
    return res;
  }

  static Future<String> upload(String url, File image, {CancelToken cancelToken}) async {
    FormData formData = new FormData.from({
      'file': UploadFileInfo(image, 'image.png')
    });

    Dio dio = new Dio();
    dio.options.connectTimeout = 10000;
    if(null != GlobalConfig.token){
      dio.options.headers = {"Authorization": GlobalConfig.token};
    }
    Response response = await dio.post(url, data: formData, cancelToken: cancelToken);

    print('http request：${url}, ${response.data}');
    String res = json.encode(response.data).toString();
    return res;
  }

  static bool checkCode(Base base, BuildContext context, { GlobalKey<ScaffoldState> scaffoldKey }) {
    if (base.code == 0) {
      return true;
    } else if (base.code == 101) {
      SharedPreferences2.delete('token');
      Router.push2(context, MainPage());
      return false;
    } else {
      if (null != scaffoldKey) {
        scaffoldKey.currentState.showSnackBar(SnackBarPicker.error(base.message));
      }
      return false;
    }
  }

}