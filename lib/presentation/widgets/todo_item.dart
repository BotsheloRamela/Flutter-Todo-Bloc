
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/domain/entities/todo.dart';
import 'package:flutter_todo_bloc/presentation/bloc/todo_bloc.dart';
import 'package:flutter_todo_bloc/presentation/bloc/todo_event.dart';
import 'package:flutter_todo_bloc/presentation/widgets/todo_dialog.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({required this.todo, super.key});

  final Todo todo;

  @override
  Widget build(BuildContext context) => ListTile(
      title: Text(
        todo.title,
        style: TextStyle(
          decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
          color: todo.isCompleted ? Colors.grey : Colors.black,
        ),
      ),
      subtitle: Text('Created at: ${todo.createdAt}'),
      trailing: Checkbox(
        value: todo.isCompleted,
        onChanged: (value) {
          context.read<TodoBloc>().add(TodoCompletionToggled(todo.id!));
        },
      ),
      onTap: () {
        todoDialog(
          context: context,
          todo: todo,
          onSave: (String title) {
            context.read<TodoBloc>().add(TodoUpdated(todo.copyWith(title: title)));
          },
        );
      },
      onLongPress: () {
        context.read<TodoBloc>().add(TodoDeleted(todo.id!));
      },
    );
}
