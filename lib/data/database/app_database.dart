
import 'package:floor/floor.dart';
import 'package:flutter_todo_bloc/data/database/todo_dao.dart';
import 'package:flutter_todo_bloc/data/database/todo_entity.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [TodoEntity])
abstract class AppDatabase extends FloorDatabase {
  TodoDao get todoDao;

  static Future<AppDatabase> init() async => $FloorAppDatabase
      .databaseBuilder('app_database.db')
      .build();
}
