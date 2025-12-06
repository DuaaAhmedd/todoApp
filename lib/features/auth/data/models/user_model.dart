class UserModel {
  int? id;
  String? imagePath;
  String? username;

  UserModel({this.id, this.imagePath, this.username});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imagePath = json['image_path'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_path'] = this.imagePath;
    data['username'] = this.username;
    return data;
  }
}
