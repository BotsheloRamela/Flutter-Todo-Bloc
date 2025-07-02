import 'package:flutter_todo_bloc/domain/entities/todo.dart';
import 'package:flutter_todo_bloc/domain/repositories/todo_repository.dart';

class GetAllTodos {
  GetAllTodos(this.repository);
  final TodoRepository repository;

  Future<List<Todo>> call() async {
    return await repository.getAllTodos();
  }
}
