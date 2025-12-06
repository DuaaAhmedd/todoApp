import 'package:todo/features/auth/data/models/user_model.dart';

class getUserModel {
  bool? status;
  UserModel? users;

  getUserModel({this.status, this.users});

  getUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    users = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.users != null) {
      data['user'] = this.users!.toJson();
    }

    return data;
  }
}
