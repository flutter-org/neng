import 'package:neng/model/topic.dart';
import 'package:neng/utils/convert.dart';

class TopicGroupModel {

  int id;

  String title;

  String gmtCreate;

  String gmtModified;

  List<TopicModel> topicModelList;

  static TopicGroupModel fromJson(Map<String, dynamic> json) {
    if (null == json) {
      throw Exception('json 不能为null');
    }
    TopicGroupModel topicGroupModel = TopicGroupModel();
    topicGroupModel.id = json['id'];
    topicGroupModel.title = json['title'];
    topicGroupModel.gmtCreate = json['gmtCreate'];
    topicGroupModel.gmtModified = json['gmtModified'];
    topicGroupModel.topicModelList = Convert.convertList<TopicModel>(TopicModel.fromJson, json['topicModelList']);
    return topicGroupModel;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['gmtCreate'] = this.gmtCreate;
    data['gmtModified'] = this.gmtModified;
    data['topicModelList'] = this.topicModelList;
    return data;
  }

}