import 'package:flutter_todo_bloc/domain/repositories/todo_repository.dart';

class DeleteTodo {
  DeleteTodo(this.repository);
  final TodoRepository repository;

  Future<void> call(int id) async {
    await repository.deleteTodo(id);
  }
}
