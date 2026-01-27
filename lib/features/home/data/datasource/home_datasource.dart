import 'package:drift/drift.dart';
import 'package:secure_task/core/database/app_database/app_database.dart';

class HomeDatasource {
  final AppDatabase _database;

  HomeDatasource(this._database);

  Future<List<Task>> getPriorityTasks() async {
    final priorityTasks =
        await (_database.select(_database.tasks)
              ..where((t) => t.priority.isBiggerThanValue(0))
              ..orderBy([
                (t) => OrderingTerm.desc(t.priority),
                (t) => OrderingTerm.desc(t.createdAt),
              ])
              ..limit(15))
            .get();

    if (priorityTasks.isNotEmpty) {
      return priorityTasks;
    }

    return await (_database.select(_database.tasks)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(15))
        .get();
  }

  Future<List<Note>> getPinnedOrRecentNotes() async {
    final pinnedNotes =
        await (_database.select(_database.notes)
              ..where((n) => n.isPinned.equals(true))
              ..orderBy([(n) => OrderingTerm.desc(n.createdAt)])
              ..limit(15))
            .get();

    if (pinnedNotes.isNotEmpty) {
      return pinnedNotes;
    }

    return await (_database.select(_database.notes)
          ..orderBy([(n) => OrderingTerm.desc(n.createdAt)])
          ..limit(15))
        .get();
  }

  Future<void> addTask({
    required String title,
    required String description,
    required int taskGroupId,
    required int userId,
    DateTime? dueDate,
    int priority = 0,
  }) async {
    await _database
        .into(_database.tasks)
        .insert(
          TasksCompanion.insert(
            title: title,
            description: Value(description),
            taskGroupId: taskGroupId,
            userId: userId,
            dueDate: Value(dueDate),
            priority: Value(priority),
          ),
        );
  }

  Future<void> addNote({
    required String title,
    required String content,
    required int userId,
    bool isPinned = false,
  }) async {
    await _database
        .into(_database.notes)
        .insert(
          NotesCompanion.insert(
            title: title,
            content: content,
            userId: userId,
            isPinned: Value(isPinned),
          ),
        );
  }

  Future<List<TaskGroup>> getTaskGroups() async {
    return await _database.select(_database.taskGroups).get();
  }
}
