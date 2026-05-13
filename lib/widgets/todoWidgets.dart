import 'package:flutter/material.dart';
import '../models/todoModels.dart';

class TodoItemWidget extends StatelessWidget {
  final TodoModel todo;
  final VoidCallback onTap;

  const TodoItemWidget({super.key, required this.todo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Checkbox(value: todo.isCompleted, onChanged: (_) => onTap()),
        title: Text(
          todo.title,
          style: TextStyle(
            fontSize: 18,
            decoration: todo.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
