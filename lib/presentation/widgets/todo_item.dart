
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/domain/entities/todo.dart';
import 'package:flutter_todo_bloc/presentation/bloc/todo_bloc.dart';
import 'package:flutter_todo_bloc/presentation/bloc/todo_event.dart';

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
          context.read<TodoBloc>().add(TodoCompletionToggled(todo.id!));
        },
      ),
      onLongPress: () {
        context.read<TodoBloc>().add(TodoDeleted(todo.id!));
      },
    );
  }
}
