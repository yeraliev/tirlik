import 'package:secure_task/core/database/app_database/app_database.dart';

abstract class HomeRepository {
  Future<List<Task>> getLastDayTasks();
  Future<List<Note>> getLastNotes();
}