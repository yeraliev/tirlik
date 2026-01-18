import 'package:secure_task/features/auth/domain/entities/user.dart';
import 'package:secure_task/features/auth/domain/repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<User> call({required String pinCode}) async {
    if (pinCode.isEmpty) {
      throw Exception('Please enter PIN code');
    }

    if (pinCode.length != 4) {
      throw Exception('PIN code must be 4 digits');
    }

    return await repository.login(pinCode: pinCode);
  }
}