import 'package:secure_task/core/database/app_database/app_database.dart';

abstract class HomeRepository {
  Future<List<Task>> getPriorityTasks();
  Future<List<Note>> getPinnedNotes();
  Future<void> addTask({
    required String title,
    required String description,
    required int taskGroupId,
    required int userId,
    DateTime? dueDate,
    int priority = 0,
  });
  Future<void> addNote({
    required String title,
    required String content,
    required int userId,
    bool isPinned = false,
  });
  Future<List<TaskGroup>> getTaskGroups();
  Future<void> updateTask({
    required int taskId,
    String? title,
    String? description,
    int? taskGroupId,
    int? priority,
    DateTime? dueDate,
    bool? isCompleted,
  });
  Future<void> deleteTask({required int taskId});
}
