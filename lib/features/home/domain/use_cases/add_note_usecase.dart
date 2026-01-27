import 'package:secure_task/features/home/domain/repository/home_repository.dart';

class AddNoteUsecase {
  final HomeRepository repository;

  AddNoteUsecase(this.repository);

  Future<void> call({
    required String title,
    required String content,
    required int userId,
    bool isPinned = false,
  }) async {
    return await repository.addNote(
      title: title,
      content: content,
      userId: userId,
      isPinned: isPinned,
    );
  }
}
