import 'package:secure_task/core/database/app_database/app_database.dart';
import 'package:secure_task/features/auth/domain/repository/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<UserData> call({
    required String name,
    required int age,
    required String job,
    required String sex,
    required String pinCode,
  }) async {
    return await repository.register(
      name: name,
      age: age,
      job: job,
      sex: sex,
      pinCodeHash: pinCode,
    );
  }
}
