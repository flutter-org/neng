class TopicModel {

  int id;

  int topicGroupId;

  String title;

  String gmtCreate;

  String gmtModified;

  int topicBrowseCount;

  static TopicModel fromJson(Map<String, dynamic> json) {
    if (null == json) {
      throw Exception('json 不能为null');
    }
    TopicModel topicModel = TopicModel();
    topicModel.id = json['id'];
    topicModel.topicGroupId = json['topicGroupId'];
    topicModel.title = json['title'];
    topicModel.gmtCreate = json['gmtCreate'];
    topicModel.gmtModified = json['gmtModified'];
    topicModel.topicBrowseCount = json['topicBrowseCount'];
    return topicModel;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['topicGroupId'] = this.topicGroupId;
    data['title'] = this.title;
    data['gmtCreate'] = this.gmtCreate;
    data['gmtModified'] = this.gmtModified;
    data['topicBrowseCount'] = this.topicBrowseCount;
    return data;
  }

}