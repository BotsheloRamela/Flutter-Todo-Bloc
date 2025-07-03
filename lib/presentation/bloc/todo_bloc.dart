import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/domain/usecases/create_todo.dart';
import 'package:flutter_todo_bloc/domain/usecases/delete_todo.dart';
import 'package:flutter_todo_bloc/domain/usecases/get_all_todos.dart';
import 'package:flutter_todo_bloc/domain/usecases/get_todo_by_id.dart';
import 'package:flutter_todo_bloc/domain/usecases/update_todo.dart';
import 'package:flutter_todo_bloc/presentation/bloc/todo_event.dart';
import 'package:flutter_todo_bloc/presentation/bloc/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {

  TodoBloc({
    required this.createTodo,
    required this.getAllTodos,
    required this.updateTodo,
    required this.deleteTodo,
    required this.getTodoById,
  }) : super(TodoState()) {
    on<TodoStarted>(_onStarted);
    on<TodoAdded>(_onTodoAdded);
    on<TodoUpdated>(_onTodoUpdated);
    on<TodoDeleted>(_onTodoDeleted);
    on<TodoCompletionToggled>(_onTodoToggled);
  }

  final CreateTodo createTodo;
  final GetAllTodos getAllTodos;
  final UpdateTodo updateTodo;
  final DeleteTodo deleteTodo;
  final GetTodoById getTodoById;

  void _onStarted(TodoStarted event, Emitter<TodoState> emit) async {
    emit(state.copyWith(status: TodoStatus.loading));
    try {
      final todos = await getAllTodos();
      emit(state.copyWith(todos: todos, status: TodoStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.error));
    }
  }

  void _onTodoAdded(TodoAdded event, Emitter<TodoState> emit) async {
    emit(state.copyWith(status: TodoStatus.loading));
    try {
      await createTodo(event.todo);
      final todos = await getAllTodos();
      emit(state.copyWith(todos: todos, status: TodoStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.error));
    }
  }

  void _onTodoUpdated(TodoUpdated event, Emitter<TodoState> emit) async {
    emit(state.copyWith(status: TodoStatus.loading));
    try {
      await updateTodo(event.todo);
      final todos = await getAllTodos();
      emit(state.copyWith(todos: todos, status: TodoStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.error));
    }
  }

  void _onTodoDeleted(TodoDeleted event, Emitter<TodoState> emit) async {
    emit(state.copyWith(status: TodoStatus.loading));
    try {
      await deleteTodo(event.todoId);
      final todos = await getAllTodos();
      emit(state.copyWith(todos: todos, status: TodoStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.error));
    }
  }

  void _onTodoToggled(TodoCompletionToggled event, Emitter<TodoState> emit) async {
    emit(state.copyWith(status: TodoStatus.loading));
    try {
      final todo = await getTodoById(event.todoId);
      if (todo != null) {
        await updateTodo(todo.copyWith(isCompleted: !todo.isCompleted));
        final todos = await getAllTodos();
        emit(state.copyWith(todos: todos, status: TodoStatus.success));
      }
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.error));
    }
  }
}
