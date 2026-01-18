 import 'package:secure_task/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login({required String pinCode});
  Future<User> register({
    required String name,
    required int age,
    required String job,
    required String sex,
    required String pinCode,
  });
  Future<User?> getCurrentUser();
  Future<void> logOut();
}