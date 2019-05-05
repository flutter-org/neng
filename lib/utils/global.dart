import 'package:flutter/material.dart';
import 'package:neng/model/user.dart';

class GlobalConfig {
  static bool dark = true;
  static ThemeData themeData = ThemeData(
    primaryColor: Color(0xFFee642c),
  );
  static Color searchBackgroundColor = Colors.white10;
  static Color cardBackgroundColor = Color(0xFF222222);
  static Color fontColor = Colors.white30;
  static Color primaryColor = Color(0xFFee642c);

  static String token;

  static String imageUrlBase = 'http://nengneng-daily.oss-cn-hangzhou.aliyuncs.com/';
//  static String host = 'http://192.168.31.254:9191';
//  static String host = 'http://192.168.1.105:9191';
  static String host = 'http://47.102.101.22:9191';
  static String projectName = '/neng-app';
  static String baseUrl = host + projectName;

  static UserModel loginUserModel;
  static BuildContext mainContext;
  static BuildContext loadingContext;

}

class GlobalApi{

  // 获取登录验证码
  static String getCode = GlobalConfig.baseUrl + '/v1/user/getCode';
  // 通过手机号登录
  static String loginByPhone = GlobalConfig.baseUrl + '/v1/user/loginByPhone';
  // 获取当前登录用户信息
  static String getLoginUser = GlobalConfig.baseUrl + '/v1/user/getLoginUser';
  // 刷新当前token
  static String refreshToken = GlobalConfig.baseUrl + '/v1/user/refresh';
  // 修改当前登录用户信息
  static String updateUser = GlobalConfig.baseUrl + '/v1/user/update';
  // 获取banner 信息接口
  static String bannerList = GlobalConfig.baseUrl + '/v1/banner/list';
  // 获取分组和话题相关信息
  static String topicListWithGroup = GlobalConfig.baseUrl + '/v1/topic/listWithGroup';
  // 获取话题条目
  static String topicListTopicItem = GlobalConfig.baseUrl + '/v1/topic/listTopicItem';
  // 获取话题条目 根据点赞数量倒序查询
  static String topicListTopicItemOrderByPraiseDesc = GlobalConfig.baseUrl + '/v1/topic/listTopicItemOrderByPraiseDesc';
  // 调教话题item
  static String topicSubmit = GlobalConfig.baseUrl + '/v1/topic/submit';
  // 获取话题条目评论
  static String topicItemCommentList = GlobalConfig.baseUrl + '/v1/topic/listTopicItemComment';
  // 提交话题item评论
  static String topicItemCommentSubmit = GlobalConfig.baseUrl + '/v1/topic/submitComment';
  // 随机获取话题条目
  static String randomTopicItem = GlobalConfig.baseUrl + '/v1/topic/randomTopicItem';
  // 获取我关注的用户 发表的话题item
  static String getMyFollowUserTopicItem = GlobalConfig.baseUrl + '/v1/topic/getMyFollowUserTopicItem';
  // 随机获取话题
  static String randomTopic = GlobalConfig.baseUrl + '/v1/topic/randomTopic';
  // 搜索话题
  static String searchTopic = GlobalConfig.baseUrl + '/v1/topic/searchTopic';
  // 获取我自己发布的话题条目
  static String getMyTopicItem = GlobalConfig.baseUrl + '/v1/topic/getMyTopicItem';
  // 获取我自己发布的话题条目的评论
  static String getMyTopicItemComment = GlobalConfig.baseUrl + '/v1/topic/getMyTopicItemComment';
  // 获取我自己发布的话题条目的赞
  static String getMyTopicItemPraise = GlobalConfig.baseUrl + '/v1/topic/getMyTopicItemPraise';
  // 获取碎片列表信息
  static String fragmentList = GlobalConfig.baseUrl + '/v1/fragment/list';
  // 根据topicId 和 topicItemId 点赞
  static String itemPraise = GlobalConfig.baseUrl + '/v1/topic/itemPraise';
  // 根据topicId 和 topicItemId 取消点赞
  static String itemUnPraise = GlobalConfig.baseUrl + '/v1/topic/itemUnPraise';
  // 用户发帖图片上传
  static String uploadTopicItemImage = GlobalConfig.baseUrl + '/v1/upload/uploadTopicItemImage';
  // 用户头像上传
  static String uploadUserImage = GlobalConfig.baseUrl + '/v1/upload/uploadUserImage';

}