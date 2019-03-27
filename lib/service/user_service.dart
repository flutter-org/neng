import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:neng/model/result.dart';
import 'package:neng/model/user.dart';
import 'package:neng/service/base_service.dart';
import 'package:neng/utils/convert.dart';
import 'package:neng/utils/global.dart';
import 'package:neng/utils/http2.dart';
import 'package:neng/utils/shared_preferences2.dart';

class UserService extends BaseService {
  
  UserService(BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) : super(context, scaffoldKey);

  Future<bool> login(String phone, String code) async {
    CancelToken cancelToken = CancelToken();
    cancelTokenList.add(cancelToken);

    String resp = await Http2.postJson(GlobalApi.loginByPhone, {'phone': phone, 'code': code}, cancelToken: cancelToken);
    Result res = Result.fromJson(jsonDecode(resp));
    if (!Http2.checkCode(res, super.context, scaffoldKey: super.scaffoldKey)) {
      return false;
    }
    SharedPreferences2.setString('token', res.data);
    GlobalConfig.token = res.data;
    return true;
  }

  Future<bool> refreshToken() async {
    CancelToken cancelToken = CancelToken();
    cancelTokenList.add(cancelToken);

    String resp = await Http2.get(GlobalApi.refreshToken, null, cancelToken: cancelToken);
    Result res = Result.fromJson(jsonDecode(resp));
    if (!Http2.checkCode(res, super.context, scaffoldKey: super.scaffoldKey)) {
      return false;
    }
    SharedPreferences2.setString('token', res.data);
    GlobalConfig.token = res.data;
    return true;
  }

  Future<bool> refreshUserModel() async {
    CancelToken cancelToken = CancelToken();
    cancelTokenList.add(cancelToken);

    String respUser = await Http2.get(GlobalApi.getLoginUser, null, cancelToken: cancelToken);
    Result resUser = Result.fromJson(jsonDecode(respUser));
    if (!Http2.checkCode(resUser, super.context, scaffoldKey: super.scaffoldKey)) {
      return false;
    }
    GlobalConfig.loginUserModel = Convert.convertObj<UserModel>(UserModel.fromJson, resUser.data);
    return true;
  }

  Future<bool> sendLoginCode(String phone) async {
    CancelToken cancelToken = CancelToken();
    cancelTokenList.add(cancelToken);

    String resp = await Http2.get(GlobalApi.getCode, {'phone': phone}, cancelToken: cancelToken);
    Result res = Result.fromJson(jsonDecode(resp));
    if (!Http2.checkCode(res, super.context, scaffoldKey: super.scaffoldKey)) {
      return false;
    }
    return true;
  }

  Future<bool> update(UserModel user) async {
    CancelToken cancelToken = CancelToken();
    cancelTokenList.add(cancelToken);

    String resp = await Http2.postJson(GlobalApi.updateUser, user, cancelToken: cancelToken);
    Result res = Result.fromJson(jsonDecode(resp));
    if (!Http2.checkCode(res, super.context, scaffoldKey: super.scaffoldKey)) {
      return false;
    }
    return true;
  }

  Future<String> uploadImage(File image) async {
    CancelToken cancelToken = CancelToken();
    cancelTokenList.add(cancelToken);

    String uploadImageStr = await Http2.upload(
        GlobalApi.uploadUserImage
        , image, cancelToken: cancelToken);
    Result uploadImageObj = Result.fromJson(
        jsonDecode(uploadImageStr));
    if (!Http2.checkCode(uploadImageObj, super.context, scaffoldKey: super.scaffoldKey)) {
      print('uploadImageObj数据失败');
      return null;
    }
    return uploadImageObj.data.toString();
  }

}