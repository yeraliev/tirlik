import 'package:secure_task/core/database/app_database/app_database.dart';
import 'package:secure_task/features/home/domain/repository/home_repository.dart';

class GetTaskGroupsUsecase {
  final HomeRepository repository;

  GetTaskGroupsUsecase(this.repository);

  Future<List<TaskGroup>> call() async {
    return await repository.getTaskGroups();
  }
}
