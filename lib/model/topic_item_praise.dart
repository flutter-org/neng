import 'package:neng/model/topic.dart';
import 'package:neng/model/topic_item.dart';
import 'package:neng/model/user.dart';
import 'package:neng/utils/convert.dart';

class TopicItemPraiseModel {

  int id;

  int topicId;

  TopicModel topic;

  int topicItemId;

  TopicItemModel topicItem;

  int topicItemUserId;

  int userId;

  UserModel user;

  String gmtCreate;

  String gmtModified;

  static TopicItemPraiseModel fromJson(Map<String, dynamic> json) {
    if (null == json) {
      throw Exception('json 不能为null');
    }
    TopicItemPraiseModel topicItemPraiseModel = TopicItemPraiseModel();
    topicItemPraiseModel.id = json['id'];
    topicItemPraiseModel.topicId = json['topicId'];
    topicItemPraiseModel.topic = Convert.convertObj<TopicModel>(TopicModel.fromJson, json['topic']);
    topicItemPraiseModel.topicItemId = json['topicItemId'];
    topicItemPraiseModel.topicItem = Convert.convertObj<TopicItemModel>(TopicItemModel.fromJson, json['topicItem']);
    topicItemPraiseModel.topicItemUserId = json['topicItemUserId'];
    topicItemPraiseModel.userId = json['userId'];
    topicItemPraiseModel.user = Convert.convertObj<UserModel>(UserModel.fromJson, json['user']);
    topicItemPraiseModel.gmtCreate = json['gmtCreate'];
    topicItemPraiseModel.gmtModified = json['gmtModified'];
    return topicItemPraiseModel;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['topicId'] = this.topicId;
    data['topic'] = this.topic;
    data['topicItemId'] = this.topicItemId;
    data['topicItem'] = this.topicItem;
    data['topicItemUserId'] = this.topicItemUserId;
    data['userId'] = this.userId;
    data['user'] = this.user;
    data['gmtCreate'] = this.gmtCreate;
    data['gmtModified'] = this.gmtModified;
    return data;
  }

}