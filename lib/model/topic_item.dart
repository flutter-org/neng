import 'package:neng/model/topic.dart';
import 'package:neng/model/user.dart';
import 'package:neng/utils/convert.dart';

class TopicItemModel {

  int id;

  int topicId;

  TopicModel topic;

  int userId;

  UserModel user;

  String text;

  String image;

  List<String> imagePojo;

  bool praise;

  int countPraise;

  int countComment;

  bool followUser;

  String gmtCreate;

  String gmtModified;

  static TopicItemModel fromJson(Map<String, dynamic> json) {
    if (null == json) {
      throw Exception('json 不能为null');
    }
    TopicItemModel topicItemModel = TopicItemModel();
    topicItemModel.id = json['id'];
    topicItemModel.topicId = json['topicId'];
    topicItemModel.topic = Convert.convertObj<TopicModel>(TopicModel.fromJson, json['topic']);
    topicItemModel.userId = json['userId'];
    topicItemModel.user = Convert.convertObj<UserModel>(UserModel.fromJson, json['user']);
    topicItemModel.text = json['text'];
    topicItemModel.image = json['image'];
    topicItemModel.imagePojo = Convert.convertStringList(json['imagePojo']);
    topicItemModel.praise = json['praise'];
    topicItemModel.countPraise = json['countPraise'];
    topicItemModel.countComment = json['countComment'];
    topicItemModel.gmtCreate = json['gmtCreate'];
    topicItemModel.gmtModified = json['gmtModified'];
    return topicItemModel;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['topicId'] = this.topicId;
    data['topic'] = this.topic;
    data['userId'] = this.userId;
    data['user'] = this.user;
    data['text'] = this.text;
    data['image'] = this.image;
    data['imagePojo'] = this.imagePojo;
    data['praise'] = this.praise;
    data['countPraise'] = this.countPraise;
    data['countComment'] = this.countComment;
    data['gmtCreate'] = this.gmtCreate;
    data['gmtModified'] = this.gmtModified;
    return data;
  }

}