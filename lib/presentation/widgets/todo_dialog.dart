
import 'package:flutter/material.dart';
import 'package:flutter_todo_bloc/domain/entities/todo.dart';

void todoDialog({
  required BuildContext context,
  required Function(String) onSave, Todo? todo,
}) {
  final TextEditingController titleController = TextEditingController(text: todo?.title ?? '');
  final bool isEditing = todo != null;

  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
        title: Text(isEditing ? 'Edit Todo' : 'Create Todo'),
        content: TextField(
          controller: titleController,
          decoration: const InputDecoration(labelText: 'Todo Title'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              onSave(titleController.text);
              Navigator.of(context).pop();
            },
            child: Text(isEditing ? 'Update' : 'Create'),
          ),
        ],
      ),
  );
}
