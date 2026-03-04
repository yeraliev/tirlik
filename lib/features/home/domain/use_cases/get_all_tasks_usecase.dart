import 'package:secure_task/core/database/app_database/app_database.dart';
import 'package:secure_task/features/home/domain/repository/home_repository.dart';

class GetAllTasksUsecase {
  final HomeRepository repository;

  GetAllTasksUsecase(this.repository);

  Future<List<Task>> call({
    DateTime? dateFilter,
    int? priorityFilter,
  }) async {
    return await repository.getAllTasks(
      dateFilter: dateFilter,
      priorityFilter: priorityFilter,
    );
  }
}
