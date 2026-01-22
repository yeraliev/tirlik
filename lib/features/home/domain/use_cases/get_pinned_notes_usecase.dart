import 'package:secure_task/core/database/app_database/app_database.dart';
import 'package:secure_task/features/home/domain/repository/home_repository.dart';

class GetPinnedNotesUsecase {
  final HomeRepository repository;

  GetPinnedNotesUsecase(this.repository);

  Future<List<Note>> call() async {
    return await repository.getPinnedNotes();
  }
}
