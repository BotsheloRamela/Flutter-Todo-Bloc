
import 'package:flutter_todo_bloc/domain/entities/todo.dart';

enum TodoStatus {
  initial,
  loading,
  success,
  error,
}

class TodoState {

  TodoState({
    this.todos = const <Todo>[],
    this.status = TodoStatus.initial,
    this.errorMessage,
  });

  final List<Todo> todos;
  final TodoStatus status;
  final String? errorMessage;

  TodoState copyWith({
    List<Todo>? todos,
    TodoStatus? status,
    String? errorMessage
  }) => TodoState(
      todos: todos ?? this.todos,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
}
