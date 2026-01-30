import 'package:secure_task/features/home/domain/repository/home_repository.dart';

class DeleteTaskUsecase {
  final HomeRepository repository;

  DeleteTaskUsecase(this.repository);

  Future<void> call({required int taskId}) async {
    await repository.deleteTask(taskId: taskId);
  }
}
