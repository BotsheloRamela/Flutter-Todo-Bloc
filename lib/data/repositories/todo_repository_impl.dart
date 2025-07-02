import 'package:flutter_todo_bloc/data/database/todo_entity.dart';
import 'package:flutter_todo_bloc/data/datasources/todo_local_datasource.dart';
import 'package:flutter_todo_bloc/data/models/todo_model.dart';
import 'package:flutter_todo_bloc/domain/entities/todo.dart';
import 'package:flutter_todo_bloc/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl(this._localDataSource);
  final TodoLocalDataSource _localDataSource;

  @override
  Future<List<Todo>> getAllTodos() async {
    final entities = await _localDataSource.getAllTodos();
    // Map data entity to domain entity
    return entities.map(_toDomain).toList();
  }

  @override
  Future<Todo?> getTodoById(String id) async {
    final entity = await _localDataSource.getTodoById(int.tryParse(id) ?? -1);
    return entity != null ? _toDomain(entity) : null;
  }

  @override
  Future<void> createTodo(Todo todo) async {
    await _localDataSource.createTodo(_toModel(todo).toEntity());
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    await _localDataSource.updateTodo(_toModel(todo).toEntity());
  }

  @override
  Future<void> deleteTodo(String id) async {
    final parsedId = int.tryParse(id);
    if (parsedId == null) throw ArgumentError('Invalid ID: $id');

    final entity = await _localDataSource.getTodoById(parsedId);
    if (entity != null) {
      await _localDataSource.deleteTodo(entity);
    }
  }

  // Helper: Map data entity to domain entity
  Todo _toDomain(TodoEntity entity) => Todo(
      id: entity.id?.toString() ?? '',
      title: entity.title,
      isCompleted: entity.isDone,
      createdAt: entity.createdAt,
    );

  // Helper: Map domain entity to data model
  TodoModel _toModel(Todo todo) => TodoModel(
      id: int.tryParse(todo.id),
      title: todo.title,
      isDone: todo.isCompleted,
      createdAt: todo.createdAt,
    );
}
