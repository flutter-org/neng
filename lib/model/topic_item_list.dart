import 'package:neng/model/topic.dart';
import 'package:neng/model/topic_item.dart';
import 'package:neng/utils/convert.dart';

class TopicItemListModel {

  TopicModel topic;

  List<TopicItemModel> items;

  static TopicItemListModel fromJson(Map<String, dynamic> json) {
    if (null == json) {
      throw Exception('json 不能为null');
    }
    TopicItemListModel topicModel = TopicItemListModel();
    topicModel.topic = Convert.convertObj<TopicModel>(TopicModel.fromJson, json['topic']);
    topicModel.items = Convert.convertList<TopicItemModel>(TopicItemModel.fromJson, json['items']);
    return topicModel;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['topic'] = this.topic;
    data['items'] = this.items;
    return data;
  }

}