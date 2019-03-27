import 'package:neng/model/base.dart';

class Result extends Base {

  dynamic data;

  int total;

  Result({
    message,
    code,
    this.data,
    this.total
  });

  Result.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    data = json['data'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    data['data'] = this.data;
    data['total'] = this.total;
    return data;
  }

}