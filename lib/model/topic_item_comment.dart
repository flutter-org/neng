import 'package:neng/model/topic.dart';
import 'package:neng/model/topic_item.dart';
import 'package:neng/model/user.dart';
import 'package:neng/utils/convert.dart';

class TopicItemCommentModel {

  int id;

  int topicId;

  TopicModel topic;

  int topicItemId;

  TopicItemModel topicItem;

  int topicItemUserId;

  int userId;

  UserModel user;

  String text;

  String image;

  String gmtCreate;

  String gmtModified;

  static TopicItemCommentModel fromJson(Map<String, dynamic> json) {
    if (null == json) {
      throw Exception('json 不能为null');
    }
    TopicItemCommentModel topicItemCommentModel = TopicItemCommentModel();
    topicItemCommentModel.id = json['id'];
    topicItemCommentModel.topicId = json['topicId'];
    topicItemCommentModel.topic = Convert.convertObj<TopicModel>(TopicModel.fromJson, json['topic']);
    topicItemCommentModel.topicItemId = json['topicItemId'];
    topicItemCommentModel.topicItem = Convert.convertObj<TopicItemModel>(TopicItemModel.fromJson, json['topicItem']);
    topicItemCommentModel.topicItemUserId = json['topicItemUserId'];
    topicItemCommentModel.userId = json['userId'];
    topicItemCommentModel.user = Convert.convertObj<UserModel>(UserModel.fromJson, json['user']);
    topicItemCommentModel.text = json['text'];
    topicItemCommentModel.image = json['image'];
    topicItemCommentModel.gmtCreate = json['gmtCreate'];
    topicItemCommentModel.gmtModified = json['gmtModified'];
    return topicItemCommentModel;
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
    data['text'] = this.text;
    data['image'] = this.image;
    data['gmtCreate'] = this.gmtCreate;
    data['gmtModified'] = this.gmtModified;
    return data;
  }

}