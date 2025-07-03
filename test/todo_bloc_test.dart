
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_bloc/domain/entities/todo.dart';
import 'package:flutter_todo_bloc/domain/usecases/create_todo.dart';
import 'package:flutter_todo_bloc/domain/usecases/delete_todo.dart';
import 'package:flutter_todo_bloc/domain/usecases/get_all_todos.dart';
import 'package:flutter_todo_bloc/domain/usecases/get_todo_by_id.dart';
import 'package:flutter_todo_bloc/domain/usecases/update_todo.dart';
import 'package:flutter_todo_bloc/presentation/bloc/todo_bloc.dart';
import 'package:flutter_todo_bloc/presentation/bloc/todo_event.dart';
import 'package:flutter_todo_bloc/presentation/bloc/todo_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([
  CreateTodo,
  GetAllTodos,
  UpdateTodo,
  DeleteTodo,
  GetTodoById,
])

import 'todo_bloc_test.mocks.dart';

void main() {
  group('TodoBloc', () {
    late MockCreateTodo mockCreateTodo;
    late MockGetAllTodos mockGetAllTodos;
    late MockUpdateTodo mockUpdateTodo;
    late MockDeleteTodo mockDeleteTodo;
    late MockGetTodoById mockGetTodoById;
    late TodoBloc todoBloc;

    // Sample test data
    final sampleTodos = [
      const Todo(id: 1, title: 'Test Todo 1', createdAt: '2025-07-01T12:00:00Z'),
      const Todo(id: 2, title: 'Test Todo 2', isCompleted: true, createdAt: '2025-07-02T12:00:00Z'),
      const Todo(title: 'Test Todo 3', createdAt: '2025-07-03T12:00:00Z'),
    ];

    setUp(() {
      mockCreateTodo = MockCreateTodo();
      mockGetAllTodos = MockGetAllTodos();
      mockUpdateTodo = MockUpdateTodo();
      mockDeleteTodo = MockDeleteTodo();
      mockGetTodoById = MockGetTodoById();

      todoBloc = TodoBloc(
        createTodo: mockCreateTodo,
        getAllTodos: mockGetAllTodos,
        updateTodo: mockUpdateTodo,
        deleteTodo: mockDeleteTodo,
        getTodoById: mockGetTodoById,
      );
    });

    tearDown(() {
      todoBloc.close();
    });

    test('initial state should be TodoState with empty todos', () {
      expect(todoBloc.state, isA<TodoState>());
      expect(todoBloc.state.todos, isEmpty);
      expect(todoBloc.state.status, TodoStatus.initial);
    });

    group('TodoStarted', () {
      blocTest<TodoBloc, TodoState>(
        'emits [loading, success] when getAllTodos succeeds',
        build: () {
          when(mockGetAllTodos()).thenAnswer((_) async => sampleTodos);
          return todoBloc;
        },
        act: (bloc) => bloc.add(TodoStarted()),
        expect: () => [
          TodoState(status: TodoStatus.loading),
          TodoState(todos: sampleTodos, status: TodoStatus.success),
        ],
      );

      blocTest<TodoBloc, TodoState>(
        'emits [loading, error] when getAllTodos fails',
        build: () {
          when(mockGetAllTodos()).thenThrow(Exception('Failed to fetch todos'));
          return todoBloc;
        },
        act: (bloc) => bloc.add(TodoStarted()),
        expect: () => [
          TodoState(status: TodoStatus.loading),
          TodoState(
            status: TodoStatus.error,
            errorMessage: 'Exception: Failed to fetch todos',
          ),
        ],
      );
    });

    group('TodoAdded', () {
      const newTodo = Todo(title: 'New Todo', createdAt: '2025-07-04T12:00:00Z');

      blocTest<TodoBloc, TodoState>(
        'emits [loading, success] when createTodo succeeds',
        build: () {
          when(mockCreateTodo(newTodo)).thenAnswer((_) async => {});
          when(mockGetAllTodos()).thenAnswer((_) async => [...sampleTodos, newTodo]);
          return todoBloc;
        },
        act: (bloc) => bloc.add(const TodoAdded(newTodo)),
        expect: () => [
          TodoState(status: TodoStatus.loading),
          TodoState(todos: [...sampleTodos, newTodo], status: TodoStatus.success),
        ],
      );

      blocTest<TodoBloc, TodoState>(
        'emits [loading, error] when createTodo fails',
        build: () {
          when(mockCreateTodo(newTodo)).thenThrow(Exception('Failed to create todo'));
          return todoBloc;
        },
        act: (bloc) => bloc.add(const TodoAdded(newTodo)),
        expect: () => [
          TodoState(status: TodoStatus.loading),
          TodoState(
            status: TodoStatus.error,
            errorMessage: 'Exception: Failed to create todo',
          ),
        ],
      );
    });

    group('TodoUpdated', () {
      const updatedTodo = Todo(id: 1, title: 'Test Todo', createdAt: '2025-07-01T12:00:00Z');

      blocTest<TodoBloc, TodoState>(
        'emits [loading, success] when updateTodo succeeds',
        build: () {
          when(mockUpdateTodo(updatedTodo)).thenAnswer((_) async => {});
          when(mockGetAllTodos()).thenAnswer((_) async => sampleTodos);
          return todoBloc;
        },
        act: (bloc) => bloc.add(const TodoUpdated(updatedTodo)),
        expect: () => [
          TodoState(status: TodoStatus.loading),
          TodoState(todos: sampleTodos, status: TodoStatus.success),
        ],
      );

      blocTest<TodoBloc, TodoState>(
        'emits [loading, error] when updateTodo fails',
        build: () {
          when(mockUpdateTodo(updatedTodo)).thenThrow(Exception('Failed to update todo'));
          return todoBloc;
        },
        act: (bloc) => bloc.add(const TodoUpdated(updatedTodo)),
        expect: () => [
          TodoState(status: TodoStatus.loading),
          TodoState(
            status: TodoStatus.error,
            errorMessage: 'Exception: Failed to update todo',
          ),
        ],
      );
    });

    group('TodoDeleted', () {
      blocTest<TodoBloc, TodoState>(
        'emits [loading, success] when deleteTodo succeeds',
        build: () {
          when(mockDeleteTodo(any)).thenAnswer((_) async => {});
          when(mockGetAllTodos()).thenAnswer((_) async => sampleTodos);
          return todoBloc;
        },
        act: (bloc) => bloc.add(const TodoDeleted(1)),
        expect: () => [
          TodoState(status: TodoStatus.loading),
          TodoState(todos: sampleTodos, status: TodoStatus.success),
        ],
      );

      blocTest<TodoBloc, TodoState>(
        'emits [loading, error] when deleteTodo fails',
        build: () {
          when(mockDeleteTodo(any)).thenThrow(Exception('Failed to delete todo'));
          return todoBloc;
        },
        act: (bloc) => bloc.add(const TodoDeleted(1)),
        expect: () => [
          TodoState(status: TodoStatus.loading),
          TodoState(
            status: TodoStatus.error,
            errorMessage: 'Exception: Failed to delete todo',
          ),
        ],
      );
    });

    group('TodoCompletionToggled', () {
      final todoToToggle = sampleTodos[0].copyWith(isCompleted: !sampleTodos[0].isCompleted);

      blocTest<TodoBloc, TodoState>(
        'emits [loading, success] when toggled succeeds',
        build: () {
          when(mockGetTodoById(any)).thenAnswer((_) async => todoToToggle);
          when(mockUpdateTodo(any)).thenAnswer((_) async => {});
          when(mockGetAllTodos()).thenAnswer((_) async => sampleTodos);
          return todoBloc;
        },
        act: (bloc) => bloc.add(const TodoCompletionToggled(1)),
        expect: () => [
          TodoState(status: TodoStatus.loading),
          TodoState(todos: sampleTodos, status: TodoStatus.success),
        ],
      );

      blocTest<TodoBloc, TodoState>(
        'emits [loading, success] when todo is not found',
        build: () {
          when(mockGetTodoById(any)).thenAnswer((_) async => null);
          when(mockGetAllTodos()).thenAnswer((_) async => sampleTodos);
          return todoBloc;
        },
        act: (bloc) => bloc.add(const TodoCompletionToggled(50)),
        expect: () => [
          TodoState(status: TodoStatus.loading),
          TodoState(
            todos: sampleTodos,
            status: TodoStatus.success,
          ),
        ],
      );

      blocTest<TodoBloc, TodoState>(
        'emits [loading, error] when toggling fails',
        build: () {
          when(mockGetTodoById(any)).thenThrow(Exception('Failed to toggle todo'));
          return todoBloc;
        },
        act: (bloc) => bloc.add(const TodoCompletionToggled(1)),
        expect: () => [
          TodoState(status: TodoStatus.loading),
          TodoState(
            status: TodoStatus.error,
            errorMessage: 'Exception: Failed to toggle todo',
          ),
        ],
      );
    });

    group('TodoFilterChanged', () {
      blocTest<TodoBloc, TodoState>(
        'emits new filter state with updated filter',
        build: () => todoBloc,
        act: (bloc) => bloc.add(const TodoFilterChanged(TodoFilter.completed)),
        expect: () => [
          TodoState(filter: TodoFilter.completed),
        ],
      );

      blocTest<TodoBloc, TodoState>(
        'emits new filter state with active filter',
        build: () => todoBloc,
        act: (bloc) => bloc.add(const TodoFilterChanged(TodoFilter.active)),
        expect: () => [
          TodoState(filter: TodoFilter.active),
        ],
      );

      // NOTE: all filter redundant as it is the default state
    });
  });
}
