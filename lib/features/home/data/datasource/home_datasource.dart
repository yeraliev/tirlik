import 'package:drift/drift.dart';
import 'package:secure_task/core/database/app_database/app_database.dart';

class HomeDatasource {
  final AppDatabase _database;

  HomeDatasource(this._database);

  Future<List<Task>> getPriorityTasks() async {
    return await (_database.select(_database.tasks)
          ..where((t) => t.isCompleted.equals(false))
          ..orderBy([
            (t) => OrderingTerm.desc(t.priority),
            (t) => OrderingTerm.desc(t.createdAt),
          ])
          ..limit(20))
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

  Future<void> createTaskGroup({
    required String name,
    required String color,
    required int userId,
    String? icon,
  }) async {
    await _database.into(_database.taskGroups).insert(
      TaskGroupsCompanion.insert(
        name: name,
        color: color,
        userId: userId,
        icon: Value(icon),
      ),
    );
  }

  Future<void> updateTask({
    required int taskId,
    String? title,
    String? description,
    int? taskGroupId,
    int? priority,
    DateTime? dueDate,
    bool? isCompleted,
  }) async {
    final companion = TasksCompanion(
      title: title != null ? Value(title) : Value.absent(),
      description: description != null ? Value(description) : Value.absent(),
      taskGroupId: taskGroupId != null ? Value(taskGroupId) : Value.absent(),
      priority: priority != null ? Value(priority) : Value.absent(),
      dueDate: dueDate != null ? Value(dueDate) : Value.absent(),
      isCompleted: isCompleted != null ? Value(isCompleted) : Value.absent(),
    );

    await (_database.update(
      _database.tasks,
    )..where((tbl) => tbl.id.equals(taskId))).write(companion);
  }

  Future<void> deleteTask({required int taskId}) async {
    await (_database.delete(
      _database.tasks,
    )..where((task) => task.id.equals(taskId))).go();
  }

  Future<List<Task>> getAllTasks({
    DateTime? dateFilter,
    int? priorityFilter,
  }) async {
    final query = _database.select(_database.tasks)
      ..orderBy([
        (t) => OrderingTerm.desc(t.priority),
        (t) => OrderingTerm.desc(t.createdAt),
      ]);

    query.where((t) {
      Expression<bool>? cond;

      if (dateFilter != null) {
        final start = DateTime(
          dateFilter.year,
          dateFilter.month,
          dateFilter.day,
        );
        final end = start.add(const Duration(days: 1));
        cond = t.dueDate.isBetweenValues(start, end);
      }

      if (priorityFilter != null) {
        final p = t.priority.equals(priorityFilter);
        cond = cond != null ? cond & p : p;
      }

      return cond ?? const Constant(true);
    });

    return await query.get();
  }

  Future<void> updateNote({
    required int noteId,
    String? title,
    String? content,
    bool? isPinned,
  }) async {
    final companion = NotesCompanion(
      title: title != null ? Value(title) : Value.absent(),
      content: content != null ? Value(content) : Value.absent(),
      isPinned: isPinned != null ? Value(isPinned) : Value.absent(),
      updatedAt: Value(DateTime.now()),
    );
    await (_database.update(
      _database.notes,
    )..where((n) => n.id.equals(noteId))).write(companion);
  }

  Future<List<Note>> searchNotes(String query) async {
    final pattern = '%$query%';
    return await (_database.select(_database.notes)
          ..where((n) => n.title.like(pattern) | n.content.like(pattern))
          ..orderBy([
            (n) => OrderingTerm.desc(n.isPinned),
            (n) => OrderingTerm.desc(n.createdAt),
          ]))
        .get();
  }
}
