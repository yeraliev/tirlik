import 'package:secure_task/features/home/domain/repository/home_repository.dart';

class AddTaskUsecase {
  final HomeRepository repository;

  AddTaskUsecase(this.repository);

  Future<void> call({
    required String title,
    required String description,
    required int taskGroupId,
    required int userId,
    DateTime? dueDate,
    int priority = 0,
  }) async {
    return await repository.addTask(
      title: title,
      description: description,
      taskGroupId: taskGroupId,
      userId: userId,
      dueDate: dueDate,
      priority: priority,
    );
  }
}
