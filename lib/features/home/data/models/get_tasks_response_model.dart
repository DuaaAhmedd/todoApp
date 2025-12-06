import 'tassk_model.dart';

class GetTasksReponseModel {
  bool? status;
  List<TaskModel>? tasks;

  GetTasksReponseModel({this.status, this.tasks});

  GetTasksReponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['tasks'] != null) {
      tasks = <TaskModel>[];
      json['tasks'].forEach((v) {
        tasks!.add(new TaskModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.tasks != null) {
      data['tasks'] = this.tasks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
