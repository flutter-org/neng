import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:neng/model/result.dart';
import 'package:neng/model/topic.dart';
import 'package:neng/model/topic_group.dart';
import 'package:neng/model/topic_item.dart';
import 'package:neng/model/topic_item_comment.dart';
import 'package:neng/model/topic_item_list.dart';
import 'package:neng/model/topic_item_praise.dart';
import 'package:neng/service/base_service.dart';
import 'package:neng/utils/convert.dart';
import 'package:neng/utils/global.dart';
import 'package:neng/utils/http2.dart';

class TopicService extends BaseService {
  
  TopicService(BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) : super(context, scaffoldKey);
  
  Future<List<TopicItemCommentModel>> topicItemCommentList(int topicItemId, int page, int size) async {
    CancelToken cancelToken = CancelToken();
    cancelTokenList.add(cancelToken);

    String topicItemCommentStr = await Http2.postJson(
        GlobalApi.topicItemCommentList
        , {'topicItemId': topicItemId, 'page': page, 'size': size}, cancelToken: cancelToken);
    Result topicItemCommentObj = Result.fromJson(
        jsonDecode(topicItemCommentStr));
    if (!Http2.checkCode(topicItemCommentObj, super.context, scaffoldKey: super.scaffoldKey)) {
      print('topicItemCommentObj数据失败');
      return List<TopicItemCommentModel>();
    }
    List<TopicItemCommentModel> list = Convert.convertList(
        TopicItemCommentModel.fromJson, topicItemCommentObj.data);
    return list;
  }

  Future<bool> topicItemCommentSubmit(TopicItemCommentModel topicItemCommentModel) async {
    CancelToken cancelToken = CancelToken();
    cancelTokenList.add(cancelToken);

    String topicItemCommentSubmitStr = await Http2.postJson(
        GlobalApi.topicItemCommentSubmit
        , topicItemCommentModel, cancelToken: cancelToken);
    Result topicItemCommentSubmitObj = Result.fromJson(
        jsonDecode(topicItemCommentSubmitStr));
    if (!Http2.checkCode(topicItemCommentSubmitObj, super.context, scaffoldKey: super.scaffoldKey)) {
      print('topicItemCommentSubmitObj数据失败');
      return false;
    }
    return true;
  }

  Future<bool> topicItemSubmit(TopicItemModel topicItemModel) async {
    CancelToken cancelToken = CancelToken();
    cancelTokenList.add(cancelToken);

    String topicItemSubmitStr = await Http2.postJson(
        GlobalApi.topicSubmit, topicItemModel, cancelToken: cancelToken);
    Result topicItemSubmitObj = Result.fromJson(
        jsonDecode(topicItemSubmitStr));
    if (!Http2.checkCode(topicItemSubmitObj, super.context, scaffoldKey: super.scaffoldKey)) {
      print('topicItemSubmitObj数据失败');
      return false;
    }
    return true;
  }

  Future<List<TopicItemModel>> getMyTopicItem(int page, int size) async {
    CancelToken cancelToken = CancelToken();
    cancelTokenList.add(cancelToken);

    String topicItemStr = await Http2.postJson(GlobalApi.getMyTopicItem
        , {'page': page, 'size': size}, cancelToken: cancelToken);
    Result topicItemObj = Result.fromJson(
        jsonDecode(topicItemStr));
    if (!Http2.checkCode(topicItemObj, super.context, scaffoldKey: super.scaffoldKey)) {
      print('topicItemObj数据失败');
      return List<TopicItemModel>();
    }
    List<TopicItemModel> list = Convert.convertList(
        TopicItemModel.fromJson, topicItemObj.data);
    return list;
  }

  Future<List<TopicItemCommentModel>> getMyTopicItemComment(int page, int size) async {
    CancelToken cancelToken = CancelToken();
    cancelTokenList.add(cancelToken);

    String topicItemCommentStr = await Http2.postJson(
        GlobalApi.getMyTopicItemComment
        , {'page': page, 'size': size}, cancelToken: cancelToken);
    Result topicItemCommentObj = Result.fromJson(
        jsonDecode(topicItemCommentStr));
    if (!Http2.checkCode(topicItemCommentObj, super.context, scaffoldKey: super.scaffoldKey)) {
      print('topicItemCommentObj数据失败');
      return List<TopicItemCommentModel>();
    }
    List<TopicItemCommentModel> list = Convert.convertList(
        TopicItemCommentModel.fromJson, topicItemCommentObj.data);
    return list;
  }

  Future<List<TopicItemPraiseModel>> getMyTopicItemPraise(int page, int size) async {
    CancelToken cancelToken = CancelToken();
    cancelTokenList.add(cancelToken);

    String topicItemPraiseStr = await Http2.postJson(
        GlobalApi.getMyTopicItemPraise
        , {'page': page, 'size': size}, cancelToken: cancelToken);
    Result topicItemPraiseObj = Result.fromJson(
        jsonDecode(topicItemPraiseStr));
    if (!Http2.checkCode(topicItemPraiseObj, super.context, scaffoldKey: super.scaffoldKey)) {
      print('topicItemPraiseObj数据失败');
      return List<TopicItemPraiseModel>();
    }
    List<TopicItemPraiseModel> list = Convert.convertList(
        TopicItemPraiseModel.fromJson, topicItemPraiseObj.data);
    return list;
  }

  Future<TopicItemListModel> topicItemList(int topicId, int page, int size) async {
    CancelToken cancelToken = CancelToken();
    cancelTokenList.add(cancelToken);

    String topicItemListStr = await Http2.postJson(
        GlobalApi.topicListTopicItem
        , {'topicId': topicId, 'page': page, 'size': size}, cancelToken: cancelToken);
    Result topicItemListObj = Result.fromJson(
        jsonDecode(topicItemListStr));
    if (!Http2.checkCode(topicItemListObj, super.context, scaffoldKey: super.scaffoldKey)) {
      print('topicItemListObj数据失败');
      return TopicItemListModel();
    }
    TopicItemListModel obj = Convert.convertObj(
        TopicItemListModel.fromJson, topicItemListObj.data);
    return obj;
  }

  Future<List<TopicItemModel>> randomTopicItem(int size) async {
    CancelToken cancelToken = CancelToken();
    cancelTokenList.add(cancelToken);

    String topicItemStr = await Http2.get(GlobalApi.randomTopicItem
        , {'size': size}, cancelToken: cancelToken);
    Result topicItemObj = Result.fromJson(
        jsonDecode(topicItemStr));
    if (!Http2.checkCode(topicItemObj, super.context, scaffoldKey: super.scaffoldKey)) {
      print('topicItemObj数据失败');
      return List<TopicItemModel>();
    }
    List<TopicItemModel> list = Convert.convertList(
        TopicItemModel.fromJson, topicItemObj.data);
    return list;
  }

  Future<List<TopicModel>> randomTopic(int size) async {
    CancelToken cancelToken = CancelToken();
    cancelTokenList.add(cancelToken);

    String topicStr = await Http2.get(GlobalApi.randomTopic
        , {'size': size}, cancelToken: cancelToken);
    Result topicObj = Result.fromJson(
        jsonDecode(topicStr));
    if (!Http2.checkCode(topicObj, super.context, scaffoldKey: super.scaffoldKey)) {
      print('topicObj数据失败');
      return List<TopicModel>();
    }
    List<TopicModel> list = Convert.convertList(
        TopicModel.fromJson, topicObj.data);
    return list;
  }

  Future<List<TopicModel>> searchTopic(String title, int page, int size) async {
    CancelToken cancelToken = CancelToken();
    cancelTokenList.add(cancelToken);

    String topicStr = await Http2.postJson(GlobalApi.searchTopic
        , {'title': title, 'page': page, 'size': size}, cancelToken: cancelToken);
    Result topicObj = Result.fromJson(
        jsonDecode(topicStr));
    if (!Http2.checkCode(topicObj, super.context, scaffoldKey: super.scaffoldKey)) {
      print('topicObj数据失败');
      return List<TopicModel>();
    }
    List<TopicModel> list = Convert.convertList(
        TopicModel.fromJson, topicObj.data);
    return list;
  }

  Future<List<TopicGroupModel>> topicListWithGroup() async {
    CancelToken cancelToken = CancelToken();
    cancelTokenList.add(cancelToken);

    String topicGroupStr = await Http2.get(GlobalApi.topicListWithGroup, null, cancelToken: cancelToken);
    Result topicGroupObj = Result.fromJson(
        jsonDecode(topicGroupStr));
    if (!Http2.checkCode(topicGroupObj, super.context, scaffoldKey: super.scaffoldKey)) {
      print('topicGroupObj数据失败');
      return List<TopicGroupModel>();
    }
    List<TopicGroupModel> list = Convert.convertList(
        TopicGroupModel.fromJson, topicGroupObj.data);
    return list;
  }

  Future<bool> itemPraise(int topicId, int topicItemId) async {
    CancelToken cancelToken = CancelToken();
    cancelTokenList.add(cancelToken);

    String itemPraiseStr = await Http2.get(
        GlobalApi.itemPraise
        , {'topicId': topicId, 'topicItemId': topicItemId}, cancelToken: cancelToken);
    Result itemPraiseObj = Result.fromJson(
        jsonDecode(itemPraiseStr));
    if (!Http2.checkCode(itemPraiseObj, super.context, scaffoldKey: super.scaffoldKey)) {
      print('itemPraiseObj数据失败');
      return false;
    }
    return true;
  }

  Future<bool> itemUnPraise(int topicId, int topicItemId) async {
    CancelToken cancelToken = CancelToken();
    cancelTokenList.add(cancelToken);

    String itemUnPraiseStr = await Http2.get(
        GlobalApi.itemUnPraise
        , {'topicId': topicId, 'topicItemId': topicItemId}, cancelToken: cancelToken);
    Result itemUnPraiseObj = Result.fromJson(
        jsonDecode(itemUnPraiseStr));
    if (!Http2.checkCode(itemUnPraiseObj, super.context, scaffoldKey: super.scaffoldKey)) {
      print('itemUnPraiseObj数据失败');
      return false;
    }
    return true;
  }

  Future<String> uploadImage(File image) async {
    CancelToken cancelToken = CancelToken();
    cancelTokenList.add(cancelToken);

    String uploadImageStr = await Http2.upload(
        GlobalApi.uploadTopicItemImage
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