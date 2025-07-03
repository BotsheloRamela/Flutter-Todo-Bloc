import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/domain/usecases/create_todo.dart';
import 'package:flutter_todo_bloc/domain/usecases/delete_todo.dart';
import 'package:flutter_todo_bloc/domain/usecases/get_all_todos.dart';
import 'package:flutter_todo_bloc/domain/usecases/get_todo_by_id.dart';
import 'package:flutter_todo_bloc/domain/usecases/update_todo.dart';
import 'package:flutter_todo_bloc/injection_container.dart';
import 'package:flutter_todo_bloc/presentation/bloc/todo_bloc.dart';
import 'package:flutter_todo_bloc/presentation/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dependencies = await setupDependencies();
  runApp(
    MultiProvider(
      providers: dependencies,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
      ),
      home: BlocProvider(
        create: (context) => TodoBloc(
          createTodo: Provider.of<CreateTodo>(context, listen: false),
          getAllTodos: Provider.of<GetAllTodos>(context, listen: false),
          updateTodo: Provider.of<UpdateTodo>(context, listen: false),
          deleteTodo: Provider.of<DeleteTodo>(context, listen: false),
          getTodoById: Provider.of<GetTodoById>(context, listen: false),
        ),
        child: const HomeScreen(),
      ),
    );
}
