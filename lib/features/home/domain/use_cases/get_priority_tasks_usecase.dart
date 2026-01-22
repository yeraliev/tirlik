import 'package:secure_task/core/database/app_database/app_database.dart';
import 'package:secure_task/features/home/domain/repository/home_repository.dart';

class GetPriorityTasksUsecase {
  final HomeRepository repository;

  GetPriorityTasksUsecase(this.repository);

  Future<List<Task>> call() async {
    return await repository.getPriorityTasks();
  }
}
