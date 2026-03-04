import 'package:secure_task/features/home/domain/repository/home_repository.dart';

class CreateTaskGroupUsecase {
  final HomeRepository repository;

  CreateTaskGroupUsecase(this.repository);

  Future<void> call({
    required String name,
    required String color,
    required int userId,
    String? icon,
  }) async {
    return await repository.createTaskGroup(
      name: name,
      color: color,
      userId: userId,
      icon: icon,
    );
  }
}
