import 'package:equatable/equatable.dart';

class Todo extends Equatable {

  const Todo({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  final String id;
  final String title;
  final String description;
  final bool isCompleted;

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) => Todo(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    isCompleted: isCompleted ?? this.isCompleted,
  );

  @override
  List<Object?> get props => [id, title, description, isCompleted];

  @override
  String toString() => 'Todo(id: $id, title: $title, description: $description, isCompleted: $isCompleted)';
}
