
import 'package:equatable/equatable.dart';
import 'package:flutter_todo_bloc/domain/entities/todo.dart';

enum TodoStatus {
  initial,
  loading,
  success,
  error,
}

enum TodoFilter { all, active, completed }

class TodoState extends Equatable{

  TodoState({
    this.todos = const <Todo>[],
    this.status = TodoStatus.initial,
    this.filter = TodoFilter.all,
    this.errorMessage,
  });

  final List<Todo> todos;
  final TodoStatus status;
  final TodoFilter filter;
  final String? errorMessage;

  List<Todo> get filteredTodos {
    switch (filter) {
      case TodoFilter.active:
        return todos.where((todo) => !todo.isCompleted).toList();
      case TodoFilter.completed:
        return todos.where((todo) => todo.isCompleted).toList();
      case TodoFilter.all:
      return todos;
    }
  }

  TodoState copyWith({
    List<Todo>? todos,
    TodoStatus? status,
    TodoFilter? filter,
    String? errorMessage
  }) => TodoState(
      todos: todos ?? this.todos,
      status: status ?? this.status,
      filter: filter ?? this.filter,
      errorMessage: errorMessage ?? this.errorMessage,
    );

  @override
  List<Object?> get props => [todos, status, filter, errorMessage];
}
