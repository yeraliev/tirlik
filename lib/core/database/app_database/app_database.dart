import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:secure_task/core/database/tables/tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [User, TaskGroups, Tasks, Notes])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        //Handle future migrations here
      },
    );
  }

  Future<void> createDefaultTaskGroups(int userId) async {
    final defaultGroups = [
      TaskGroupsCompanion.insert(
        name: 'Personal',
        description: const Value('Personal tasks and goals'),
        color: '#FF6B35',
        icon: const Value('person'),
        userId: userId,
      ),
      TaskGroupsCompanion.insert(
        name: 'Work',
        description: const Value('Work-related tasks'),
        color: '#4A90E2',
        icon: const Value('work'),
        userId: userId,
      ),
      TaskGroupsCompanion.insert(
        name: 'Shopping',
        description: const Value('Shopping lists and errands'),
        color: '#00C853',
        icon: const Value('shopping_cart'),
        userId: userId,
      ),
      TaskGroupsCompanion.insert(
        name: 'Ideas',
        description: const Value('Future ideas and plans'),
        color: '#7C4DFF',
        icon: const Value('lightbulb'),
        userId: userId,
      ),
    ];

    for (final group in defaultGroups) {
      await into(taskGroups).insert(group);
    }
  }

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'secure_task_database.db'));
      return NativeDatabase(file);
    });
  }
}
