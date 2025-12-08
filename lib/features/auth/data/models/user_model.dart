import '/features/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    super.id,
    super.imagePath,
    super.username,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      imagePath: json['image_path'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image_path'] = imagePath;
    data['username'] = username;
    return data;
  }
}
