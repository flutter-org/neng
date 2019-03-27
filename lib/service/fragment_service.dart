import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/src/material/scaffold.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:neng/model/fragment.dart';
import 'package:neng/model/result.dart';
import 'package:neng/service/base_service.dart';
import 'package:neng/utils/convert.dart';
import 'package:neng/utils/global.dart';
import 'package:neng/utils/http2.dart';

class FragmentService extends BaseService {

  FragmentService(BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) : super(context, scaffoldKey);

  Future<List<FragmentModel>> fragmentList(int page, int size) async {
    CancelToken cancelToken = CancelToken();
    cancelTokenList.add(cancelToken);

    String fragmentStr = await Http2.get(
        GlobalApi.fragmentList
        , {'page': page, 'size': size}, cancelToken: cancelToken);
    Result fragmentObj = Result.fromJson(
        jsonDecode(fragmentStr));
    if (!Http2.checkCode(fragmentObj, super.context, scaffoldKey: super.scaffoldKey)) {
      print('fragmentObj数据失败');
      return List<FragmentModel>();
    }
    List<FragmentModel> list = Convert.convertList(
        FragmentModel.fromJson, fragmentObj.data);
    return list;
  }

}