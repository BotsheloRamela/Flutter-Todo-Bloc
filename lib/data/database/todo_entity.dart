
import 'package:floor/floor.dart' show entity, primaryKey, ColumnInfo;

@entity
class TodoEntity {
  TodoEntity({
    required this.title, required this.isDone, required this.createdAt, this.id,
  });

  @primaryKey
  final int? id; // Nullable for auto-increment

  @ColumnInfo(name: 'title')
  final String title;

  @ColumnInfo(name: 'is_done')
  final bool isDone;

  @ColumnInfo(name: 'created_at')
  final String createdAt;
}
