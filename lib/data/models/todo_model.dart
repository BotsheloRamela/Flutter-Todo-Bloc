import 'package:flutter_todo_bloc/data/database/todo_entity.dart';

class TodoModel extends TodoEntity {
  TodoModel({
    required super.title,
    required super.isDone,
    required super.createdAt,
    super.id,
  });

  /// Creates a TodoModel from a json map
  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
    id: json['id'] as int?,
    title: json['title'] as String,
    isDone: json['isDone'] as bool,
    createdAt: json['createdAt'] as String,
  );

  // Factory method to create a TodoModel from a TodoEntity
  factory TodoModel.fromEntity(TodoEntity entity) => TodoModel(
    id: entity.id,
    title: entity.title,
    isDone: entity.isDone,
    createdAt: entity.createdAt,
  );

  // Method to convert a TodoModel to a TodoEntity
  TodoEntity toEntity() => TodoEntity(
    id: id,
    title: title,
    isDone: isDone,
    createdAt: createdAt,
  );

  @override
  String toString() => 'TodoModel(id: $id, title: $title, isDone: $isDone, createdAt: $createdAt)';

  /// Converts the TodoModel to a json map
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'isDone': isDone,
    'createdAt': createdAt,
  };
}
