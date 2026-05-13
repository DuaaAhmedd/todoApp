import 'package:flutter/material.dart';
import '../models/todoModels.dart';

class TodoViewModel extends ChangeNotifier {
  final List<TodoModel> _todos = [];

  List<TodoModel> get todos => _todos;

  void addTodo(String title) {
    if (title.trim().isEmpty) return;

    _todos.add(TodoModel(title: title));

    notifyListeners();
  }

  void toggleTodo(int index) {
    _todos[index].isCompleted = !_todos[index].isCompleted;
    notifyListeners();
  }
}
