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
}
