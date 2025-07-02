import 'package:flutter_todo_bloc/data/database/app_database.dart';
import 'package:flutter_todo_bloc/data/datasources/todo_local_datasource.dart';
import 'package:flutter_todo_bloc/data/repositories/todo_repository_impl.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

Future<List<SingleChildWidget>> setupDependencies() async {
  final database = await AppDatabase.init();

  return [
    Provider<AppDatabase>.value(value: database),

    Provider<TodoLocalDataSource>(
      create: (_) => TodoLocalDataSource(database),
    ),

    ProxyProvider<TodoLocalDataSource, TodoRepositoryImpl>(
      update: (_, todoLocalDataSource, __) => TodoRepositoryImpl(todoLocalDataSource)
    ),

    // TODO: Add providers for use cases, view models, etc. -> Bloc
  ];
}