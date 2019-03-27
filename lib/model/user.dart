class UserModel {

  int id;

  String phone;

  String nickName;

  String photo;

  String sign;

  String province;

  String city;

  String area;

  String address;

  int sex;

  String birthday;

  String gmtCreate;

  String gmtModified;

  String getSexView() {
    if (0 == sex) {
      return '未知';
    } else if (1 == sex) {
      return '男';
    } else if (2 == sex) {
      return '女';
    }
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    if (null == json) {
      throw Exception('json 不能为null');
    }
    UserModel userModel = UserModel();
    userModel.id = json['id'];
    userModel.phone = json['phone'];
    userModel.nickName = json['nickName'];
    userModel.photo = json['photo'];
    userModel.sign = json['sign'];
    userModel.province = json['province'];
    userModel.city = json['city'];
    userModel.area = json['area'];
    userModel.address = json['address'];
    userModel.sex = json['sex'];
    userModel.birthday = json['birthday'];
    userModel.gmtCreate = json['gmtCreate'];
    userModel.gmtModified = json['gmtModified'];
    return userModel;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['nickName'] = this.nickName;
    data['photo'] = this.photo;
    data['sign'] = this.sign;
    data['province'] = this.province;
    data['city'] = this.city;
    data['area'] = this.area;
    data['address'] = this.address;
    data['sex'] = this.sex;
    data['birthday'] = this.birthday;
    data['gmtCreate'] = this.gmtCreate;
    data['gmtModified'] = this.gmtModified;
    return data;
  }

}