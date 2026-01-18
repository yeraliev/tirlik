import 'package:secure_task/core/database/app_database/app_database.dart';
import 'package:secure_task/features/auth/domain/repository/auth_repository.dart';

class GetcurrentuserUsecase {
  AuthRepository repository;

  GetcurrentuserUsecase({required this.repository});

  Future<UserData?> getCurrentUser() async {
    return await repository.getCurrentUser();
  }
}
