import 'package:secure_task/features/auth/domain/entities/user.dart';
import 'package:secure_task/features/auth/domain/repository/auth_repository.dart';

class GetcurrentuserUsecase {
  AuthRepository repository;

  GetcurrentuserUsecase({required this.repository});

  Future<User?> getCurrentUser() async {
    return await repository.getCurrentUser();
  }
}