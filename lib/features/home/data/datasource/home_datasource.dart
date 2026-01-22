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
}
