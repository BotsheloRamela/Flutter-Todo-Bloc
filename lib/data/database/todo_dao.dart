
import 'package:floor/floor.dart';
import 'package:flutter_todo_bloc/data/database/todo_entity.dart';

@dao
abstract class TodoDao {
  @Query('SELECT * FROM todos')
  Future<List<TodoEntity>> getAllTodos();

  @Query('SELECT * FROM todos WHERE id = :id')
  Future<TodoEntity?> getTodoById(int id);

  @insert
  Future<void> insertTodo(TodoEntity todo);

  @update
  Future<void> updateTodo(TodoEntity todo);

  @delete
  Future<void> deleteTodo(TodoEntity todo);
}