import 'package:flutter_todo_bloc/data/database/app_database.dart';
import 'package:flutter_todo_bloc/data/datasources/todo_local_datasource.dart';
import 'package:flutter_todo_bloc/data/repositories/todo_repository_impl.dart';
import 'package:flutter_todo_bloc/domain/repositories/todo_repository.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

Future<List<SingleChildWidget>> setupDependencies() async {
  final database = await AppDatabase.init();

  return [
    Provider<AppDatabase>.value(value: database),

    Provider<TodoLocalDataSource>(
      create: (_) => TodoLocalDataSource(database),
    ),

    // Provides the concrete implementation for advanced scenarios (e.g., direct access, testing, or chaining)
    Provider<TodoRepositoryImpl>(
      create: (context) => TodoRepositoryImpl(
        Provider.of<TodoLocalDataSource>(context, listen: false),
      ),
    ),

    // Provides the domain abstraction (interface) for use throughout the app, enabling decoupling and testability
    Provider<TodoRepository>(
      create: (context) => Provider.of<TodoRepositoryImpl>(context, listen: false),
    ),

    // TODO: Maybe add providers for use cases, view models, etc. -> Bloc
  ];
}
