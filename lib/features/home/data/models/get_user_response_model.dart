import 'package:todo/features/auth/data/models/user_model.dart';

class getUserModel {
  bool? status;
  UserModel? users;

  getUserModel({this.status, this.users});

  getUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    users = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (users != null) {
      data['user'] = users!.toJson();
    }

    return data;
  }
}
