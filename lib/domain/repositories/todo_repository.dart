import 'package:flutter_todo_bloc/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> getAllTodos();
  Future<Todo?> getTodoById(int id);
  Future<void> createTodo(Todo todo);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(int id);
}
