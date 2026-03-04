import 'package:secure_task/core/database/app_database/app_database.dart';
import 'package:secure_task/features/home/domain/repository/home_repository.dart';

class SearchNotesUsecase {
  final HomeRepository repository;

  SearchNotesUsecase(this.repository);

  Future<List<Note>> call(String query) async {
    return await repository.searchNotes(query);
  }
}
