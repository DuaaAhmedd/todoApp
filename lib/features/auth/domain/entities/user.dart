import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String? imagePath;
  final String? username;

  const User({
    this.id,
    this.imagePath,
    this.username,
  });

  @override
  List<Object?> get props => [id, imagePath, username];
}
