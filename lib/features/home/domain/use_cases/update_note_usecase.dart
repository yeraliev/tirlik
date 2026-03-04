import 'package:secure_task/features/home/domain/repository/home_repository.dart';

class UpdateNoteUsecase {
  final HomeRepository repository;

  UpdateNoteUsecase(this.repository);

  Future<void> call({
    required int noteId,
    String? title,
    String? content,
    bool? isPinned,
  }) async {
    return await repository.updateNote(
      noteId: noteId,
      title: title,
      content: content,
      isPinned: isPinned,
    );
  }
}
