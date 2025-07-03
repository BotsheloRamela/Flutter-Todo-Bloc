
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/core/date_time_utils.dart';
import 'package:flutter_todo_bloc/domain/entities/todo.dart';
import 'package:flutter_todo_bloc/presentation/bloc/todo_bloc.dart';
import 'package:flutter_todo_bloc/presentation/bloc/todo_event.dart';
import 'package:flutter_todo_bloc/presentation/bloc/todo_state.dart';
import 'package:flutter_todo_bloc/presentation/widgets/todo_dialog.dart';
import 'package:flutter_todo_bloc/presentation/widgets/todo_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(TodoStarted());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('My Todos'),
        actions: [
          PopupMenuButton<TodoFilter>(
            onSelected: (filter) {
              context.read<TodoBloc>().add(TodoFilterChanged(filter));
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: TodoFilter.all,
                child: Text('All'),
              ),
              const PopupMenuItem(
                value: TodoFilter.active,
                child: Text('Active'),
              ),
              const PopupMenuItem(
                value: TodoFilter.completed,
                child: Text('Completed'),
              ),
            ],
            icon: const Icon(Icons.filter_list, size: 28.0),
          )
        ],
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state.status == TodoStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          final todos = state.filteredTodos;

          if (todos.isEmpty) {
            return const Center(child: Text('No todos available'));
          } else {
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return TodoItem(todo: todo);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          todoDialog(context: context, onSave: (String title) {
            context.read<TodoBloc>().add(TodoAdded(Todo(
                title: title,
                createdAt: DateTimeUtils.getCurrentUtcTimestamp()
            )));
          });
        },
        child: const Icon(Icons.add),
      ),
    );
}
