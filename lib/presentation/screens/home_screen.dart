
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
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state.status == TodoStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.todos.isEmpty) {
            return const Center(child: Text('No todos available'));
          } else {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];
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
