import 'package:secure_task/features/auth/domain/entities/user.dart';
import 'package:secure_task/features/auth/domain/repository/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<User> call({
    required String name,
    required int age,
    required String job,
    required String sex,
    required String pinCode,
  }) async {
    if (name.isEmpty) {
      throw Exception('Name cannot be empty');
    }

    if (age < 1 || age > 150) {
      throw Exception('Please enter a valid age');
    }

    if (job.isEmpty) {
      throw Exception('Job cannot be empty');
    }

    if (sex.isEmpty) {
      throw Exception('Please select sex');
    }

    if (pinCode.length != 4) {
      throw Exception('PIN code must be 4 digits');
    }

    return await repository.register(
      name: name,
      age: age,
      job: job,
      sex: sex,
      pinCode: pinCode,
    );
  }
}
