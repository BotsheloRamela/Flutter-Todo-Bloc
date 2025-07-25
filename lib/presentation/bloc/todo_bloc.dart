import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/core/logger.dart';
import 'package:flutter_todo_bloc/domain/entities/todo.dart';
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
    on<TodoFilterChanged>(_onFilterChanged);
  }

  final CreateTodo createTodo;
  final GetAllTodos getAllTodos;
  final UpdateTodo updateTodo;
  final DeleteTodo deleteTodo;
  final GetTodoById getTodoById;

  void _onStarted(TodoStarted event, Emitter<TodoState> emit) async {
    logger.d('TodoBloc: _onStarted called');
    await _performActionWithReload(emit, () async => getAllTodos());
  }

  void _onTodoAdded(TodoAdded event, Emitter<TodoState> emit) async {
    logger.d('TodoBloc: _onTodoAdded called with todo: ${event.todo}');
    await _performActionWithReload(emit, () async {
      await createTodo(event.todo);
      return getAllTodos();
    });
  }

  void _onTodoUpdated(TodoUpdated event, Emitter<TodoState> emit) async {
    logger.d('TodoBloc: _onTodoUpdated called with todo: ${event.todo}');
    await _performActionWithReload(emit, () async {
      await updateTodo(event.todo);
      return getAllTodos();
    });
  }

  void _onTodoDeleted(TodoDeleted event, Emitter<TodoState> emit) async {
    logger.d('TodoBloc: _onTodoDeleted called with todoId: ${event.todoId}');
    await _performActionWithReload(emit, () async {
      await deleteTodo(event.todoId);
      return getAllTodos();
    });
  }

  void _onTodoToggled(TodoCompletionToggled event, Emitter<TodoState> emit) async {
    logger.d('TodoBloc: _onTodoToggled called with todoId: ${event.todoId}');

    await _performActionWithReload(emit, () async {
      final todo = await getTodoById(event.todoId);
      if (todo != null) {
        await updateTodo(todo.copyWith(isCompleted: !todo.isCompleted));
      }
      return getAllTodos();
    });
  }

  void _onFilterChanged(TodoFilterChanged event, Emitter<TodoState> emit) {
    logger.d('TodoBloc: _onFilterChanged called with filter: ${event.filter}');
    emit(state.copyWith(filter: event.filter));
  }

  Future<void> _performActionWithReload(
    Emitter<TodoState> emit,
    Future<List<Todo>> Function() action
  ) async {
    emit(state.copyWith(status: TodoStatus.loading));
    try {
      final todos = await action();
      emit(state.copyWith(todos: todos, status: TodoStatus.success));
      logger.d('TodoBloc: Action completed successfully, todos count: ${todos.length}');
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.error, errorMessage: e.toString()));
      logger.e('TodoBloc: Error during action: $e');
    }
  }
}
