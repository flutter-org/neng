import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:neng/model/banner.dart';
import 'package:neng/model/result.dart';
import 'package:neng/service/base_service.dart';
import 'package:neng/utils/convert.dart';
import 'package:neng/utils/global.dart';
import 'package:neng/utils/http2.dart';

class BannerService extends BaseService {

  BannerService(BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) : super(context, scaffoldKey);

  Future<List<BannerModel>> bannerList() async {
    String bannerStr = await Http2.get(GlobalApi.bannerList, null);
    Result bannerObj = Result.fromJson(
        jsonDecode(bannerStr));
    if (!Http2.checkCode(bannerObj, super.context, scaffoldKey: super.scaffoldKey)) {
      print('bannerObj数据失败');
      return List<BannerModel>();
    }
    List<BannerModel> list = Convert.convertList(
        BannerModel.fromJson, bannerObj.data);
    return list;
  }


}