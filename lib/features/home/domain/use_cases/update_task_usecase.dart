import 'package:secure_task/features/home/domain/repository/home_repository.dart';

class UpdateTaskUseCase {
  final HomeRepository repository;

  UpdateTaskUseCase(this.repository);

  Future<void> call({
    required int taskId,
    String? title,
    String? description,
    int? taskGroupId,
    int? priority,
    DateTime? dueDate,
    bool? isCompleted,
  }) async {
    await repository.updateTask(
      taskId: taskId,
      title: title,
      description: description,
      taskGroupId: taskGroupId,
      priority: priority,
      dueDate: dueDate,
      isCompleted: isCompleted,
    );
  }
}
