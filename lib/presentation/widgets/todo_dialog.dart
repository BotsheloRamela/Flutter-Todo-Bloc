
import 'package:flutter/material.dart';
import 'package:flutter_todo_bloc/domain/entities/todo.dart';

void todoDialog({
  required BuildContext context,
  required Function(String) onSave, Todo? todo,
}) {
  final TextEditingController titleController = TextEditingController(text: todo?.title ?? '');
  final bool isEditing = todo != null;
  final formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
        title: Text(isEditing ? 'Edit Todo' : 'Create Todo'),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
              hintText: 'Enter a title',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                onSave(titleController.text.trim());
                Navigator.of(context).pop();
              }
            },
            child: Text(isEditing ? 'Update' : 'Create'),
          ),
        ],
      ),
  );
}
