import 'package:flutter_todo_bloc/domain/entities/todo.dart';
import 'package:flutter_todo_bloc/domain/repositories/todo_repository.dart';

class CreateTodo {
  CreateTodo(this.repository);
  final TodoRepository repository;

  Future<void> call(Todo todo) async {
    await repository.createTodo(todo);
  }
}
