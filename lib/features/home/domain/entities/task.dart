import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String? createdAt;
  final String? description;
  final int? id;
  final String? imagePath;
  final String? title;

  const Task({
    this.createdAt,
    this.description,
    this.id,
    this.imagePath,
    this.title,
  });

  @override
  List<Object?> get props => [createdAt, description, id, imagePath, title];
}
