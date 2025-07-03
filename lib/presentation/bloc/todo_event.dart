
import 'package:equatable/equatable.dart';
import 'package:flutter_todo_bloc/domain/entities/todo.dart';

abstract class TodoEvent extends Equatable{
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class TodoStarted extends TodoEvent {}

class TodoAdded extends TodoEvent {

  const TodoAdded(this.todo);

  final Todo todo;

  @override
  List<Object?> get props => [todo];
}

class TodoUpdated extends TodoEvent {

  const TodoUpdated(this.todo);

  final Todo todo;

  @override
  List<Object?> get props => [todo];
}

class TodoDeleted extends TodoEvent {
  const TodoDeleted(this.todoId);

  final String todoId;

  @override
  List<Object?> get props => [todoId];
}

class TodoCompletionToggled extends TodoEvent {
  const TodoCompletionToggled(this.todoId);

  final String todoId;

  @override
  List<Object?> get props => [todoId];
}
