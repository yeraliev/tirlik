import 'package:secure_task/core/database/app_database/app_database.dart';

abstract class HomeRepository {
  Future<List<Task>> getPriorityTasks();
  Future<List<Note>> getPinnedNotes();
}
