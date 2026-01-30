import 'package:secure_task/core/database/app_database/app_database.dart';
import 'package:secure_task/features/home/data/datasource/home_datasource.dart';
import 'package:secure_task/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDatasource datasource;

  HomeRepositoryImpl(this.datasource);

  @override
  Future<List<Note>> getPinnedNotes() async {
    try {
      return await datasource.getPinnedOrRecentNotes();
    } catch (e) {
      throw Exception('Failed to fetch notes: $e');
    }
  }

  @override
  Future<List<Task>> getPriorityTasks() async {
    try {
      return await datasource.getPriorityTasks();
    } catch (e) {
      throw Exception('Failed to fetch tasks: $e');
    }
  }

  @override
  Future<void> addNote({
    required String title,
    required String content,
    required int userId,
    bool isPinned = false,
  }) async {
    try {
      await datasource.addNote(
        title: title,
        content: content,
        userId: userId,
        isPinned: isPinned,
      );
    } catch (e) {
      throw Exception('Failed to add note: $e');
    }
  }

  @override
  Future<void> addTask({
    required String title,
    required String description,
    required int taskGroupId,
    required int userId,
    DateTime? dueDate,
    int priority = 0,
  }) async {
    try {
      await datasource.addTask(
        title: title,
        description: description,
        taskGroupId: taskGroupId,
        userId: userId,
        dueDate: dueDate,
        priority: priority,
      );
    } catch (e) {
      throw Exception('Failed to add task: $e');
    }
  }

  @override
  Future<List<TaskGroup>> getTaskGroups() async {
    try {
      return await datasource.getTaskGroups();
    } catch (e) {
      throw Exception('Failed to fetch task groups: $e');
    }
  }

  @override
  Future<void> updateTask({
    required int taskId,
    String? title,
    String? description,
    int? taskGroupId,
    int? priority,
    DateTime? dueDate,
    bool? isCompleted,
  }) async {
    try {
      await datasource.updateTask(
        taskId: taskId,
        title: title,
        description: description,
        taskGroupId: taskGroupId,
        priority: priority,
        dueDate: dueDate,
        isCompleted: isCompleted,
      );
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }

  @override
  Future<void> deleteTask({required int taskId}) async {
    try {
      await datasource.deleteTask(taskId: taskId);
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }
}
