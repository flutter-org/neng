class FragmentModel {

  int id;

  int type;

  String title;

  String author;

  String image;

  String music;

  String content;

  String gmtCreate;

  String gmtModified;

  static FragmentModel fromJson(Map<String, dynamic> json) {
    if (null == json) {
      throw Exception('json 不能为null');
    }
    FragmentModel fragmentModel = FragmentModel();
    fragmentModel.id = json['id'];
    fragmentModel.type = json['type'];
    fragmentModel.title = json['title'];
    fragmentModel.author = json['author'];
    fragmentModel.image = json['image'];
    fragmentModel.music = json['music'];
    fragmentModel.content = json['content'];
    fragmentModel.gmtCreate = json['gmtCreate'];
    fragmentModel.gmtModified = json['gmtModified'];
    return fragmentModel;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['title'] = this.title;
    data['author'] = this.author;
    data['image'] = this.image;
    data['music'] = this.music;
    data['content'] = this.content;
    data['gmtCreate'] = this.gmtCreate;
    data['gmtModified'] = this.gmtModified;
    return data;
  }

}