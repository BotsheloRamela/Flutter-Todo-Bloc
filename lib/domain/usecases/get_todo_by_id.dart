import 'package:flutter_todo_bloc/domain/entities/todo.dart';
import 'package:flutter_todo_bloc/domain/repositories/todo_repository.dart';

class GetTodoById {
  GetTodoById(this.repository);
  final TodoRepository repository;

  Future<Todo?> call(String id) async {
    return await repository.getTodoById(id);
  }
}
