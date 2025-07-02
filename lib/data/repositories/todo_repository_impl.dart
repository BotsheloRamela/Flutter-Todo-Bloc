import 'package:flutter_todo_bloc/data/datasources/todo_local_datasource.dart';
import 'package:flutter_todo_bloc/data/models/todo_model.dart';

class TodoRepositoryImpl {

  TodoRepositoryImpl(this._localDataSource);
  final TodoLocalDataSource _localDataSource;

  Future<List<TodoModel>> getAllTodos() async {
    final entities = await _localDataSource.getAllTodos();
    return entities.map(TodoModel.fromEntity).toList();
  }

  Future<TodoModel?> getTodoById(int id) async {
    final entity = await _localDataSource.getTodoById(id);
    return entity != null ? TodoModel.fromEntity(entity) : null;
  }

  Future<void> createTodo(TodoModel todo) async {
    await _localDataSource.createTodo(todo.toEntity());
  }

  Future<void> updateTodo(TodoModel todo) async {
    await _localDataSource.updateTodo(todo.toEntity());
  }

  Future<void> deleteTodo(TodoModel todo) async {
    await _localDataSource.deleteTodo(todo.toEntity());
  }
}
