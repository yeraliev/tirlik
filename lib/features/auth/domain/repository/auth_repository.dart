import 'package:secure_task/core/database/app_database/app_database.dart';

abstract class AuthRepository {
  Future<UserData> login({required String pinCode});
  Future<UserData> register({
    required String name,
    required int age,
    required String job,
    required String sex,
    required String pinCodeHash,
  });
  Future<UserData?> getCurrentUser();
  Future<void> logOut();
}
