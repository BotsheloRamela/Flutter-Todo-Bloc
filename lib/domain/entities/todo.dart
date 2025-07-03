import 'package:equatable/equatable.dart';

class Todo extends Equatable {

  const Todo({
    this.id,
    required this.title,
    required this.createdAt,
    this.isCompleted = false,
  });

  final int? id;
  final String title;
  final bool isCompleted;
  final String createdAt;

  Todo copyWith({
    int? id,
    String? title,
    bool? isCompleted,
    String? createdAt,
  }) => Todo(
    id: id ?? this.id,
    title: title ?? this.title,
    isCompleted: isCompleted ?? this.isCompleted,
    createdAt: createdAt ?? this.createdAt,
  );

  @override
  List<Object?> get props => [id, title, isCompleted, createdAt];

  @override
  String toString() => 'Todo(id: $id, title: $title, isCompleted: $isCompleted, createdAt: $createdAt)';
}
