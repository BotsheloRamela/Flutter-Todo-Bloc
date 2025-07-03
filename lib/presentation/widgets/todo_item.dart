
import 'package:flutter/material.dart';
import 'package:flutter_todo_bloc/domain/entities/todo.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({required this.todo, super.key});

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    // TODO: Convert time to a more readable format
    return ListTile(
      title: Text(todo.title),
      subtitle: Text('Created at: ${todo.createdAt}'),
      trailing: Checkbox(
        value: todo.isCompleted,
        onChanged: (value) {
          // Handle checkbox state change
          // This could be a callback to update the todo item
        },
      ),
    );
  }
}
