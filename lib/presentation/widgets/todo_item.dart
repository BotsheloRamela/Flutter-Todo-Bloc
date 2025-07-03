
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/core/date_time_utils.dart';
import 'package:flutter_todo_bloc/domain/entities/todo.dart';
import 'package:flutter_todo_bloc/presentation/bloc/todo_bloc.dart';
import 'package:flutter_todo_bloc/presentation/bloc/todo_event.dart';
import 'package:flutter_todo_bloc/presentation/widgets/todo_dialog.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({required this.todo, super.key});

  final Todo todo;

  @override
  Widget build(BuildContext context) => Dismissible(
    key: Key(todo.id!.toString()),
    direction: DismissDirection.endToStart,
    onDismissed: (direction) {
      context.read<TodoBloc>().add(TodoDeleted(todo.id!));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${todo.title} deleted')),
      );
    },
    background: Container(
      color: Colors.red,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 16.0),
      child: const Icon(Icons.delete, color: Colors.white),
    ),
    child: ListTile(
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
            color: todo.isCompleted ? Colors.grey : Colors.black,
            fontWeight: todo.isCompleted ? FontWeight.w400 : FontWeight.w600,
          ),
        ),
        subtitle: Text(DateTimeUtils.formatUtcTimestampToDate(todo.createdAt) ?? ''),
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
      ),
  );
}
