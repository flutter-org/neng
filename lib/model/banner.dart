class BannerModel {

  BannerModel() {}

  int id;

  String image;

  int type;

  String target;

  String gmtCreate;

  String gmtModified;

  static BannerModel fromJson(Map<String, dynamic> json) {
    if (null == json) {
      throw Exception('json 不能为null');
    }
    BannerModel bannerModel = BannerModel();
    bannerModel.id = json['id'];
    bannerModel.image = json['image'];
    bannerModel.type = json['type'];
    bannerModel.target = json['target'];
    bannerModel.gmtCreate = json['gmtCreate'];
    bannerModel.gmtModified = json['gmtModified'];
    return bannerModel;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['type'] = this.type;
    data['target'] = this.target;
    data['gmtCreate'] = this.gmtCreate;
    data['gmtModified'] = this.gmtModified;
    return data;
  }

}