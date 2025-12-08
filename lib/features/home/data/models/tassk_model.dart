import '/features/home/domain/entities/task.dart';

class TaskModel extends Task {
  const TaskModel({
    super.createdAt,
    super.description,
    super.id,
    super.imagePath,
    super.title,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      createdAt: json['created_at'],
      description: json['description'],
      id: json['id'],
      imagePath: json['image_path'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['description'] = description;
    data['id'] = id;
    data['image_path'] = imagePath;
    data['title'] = title;
    return data;
  }
}
