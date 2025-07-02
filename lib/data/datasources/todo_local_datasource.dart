import 'package:flutter_todo_bloc/data/database/app_database.dart';
import 'package:flutter_todo_bloc/data/database/todo_entity.dart';

class TodoLocalDataSource {

  TodoLocalDataSource(this._db);

  final AppDatabase _db;

  Future<List<TodoEntity>> getAllTodos() async {
    try {
      return await _db.todoDao.getAllTodos();
    } catch (e) {
      throw Exception('Failed to fetch todos: $e');
    }
  }

  Future<TodoEntity?> getTodoById(int id) async {
    try {
      return await _db.todoDao.getTodoById(id);
    } catch (e) {
      throw Exception('Failed to fetch todo by id: $e');
    }
  }

  Future<void> createTodo(TodoEntity todo) async {
    try {
      await _db.todoDao.insertTodo(todo);
    } catch (e) {
      throw Exception('Failed to create todo: $e');
    }
  }

  Future<void> updateTodo(TodoEntity todo) async {
    try {
      await _db.todoDao.updateTodo(todo);
    } catch (e) {
      throw Exception('Failed to update todo: $e');
    }
  }

  Future<void> deleteTodo(TodoEntity todo) async {
    try {
      await _db.todoDao.deleteTodo(todo);
    } catch (e) {
      throw Exception('Failed to delete todo: $e');
    }
  }
}
