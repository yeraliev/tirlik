import 'package:secure_task/core/database/app_database/app_database.dart';
import 'package:secure_task/features/auth/data/datasource/auth_datasource.dart';
import 'package:secure_task/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _datasource;

  AuthRepositoryImpl(this._datasource);

  @override
  Future<UserData?> getCurrentUser() async {
    try {
      return await _datasource.getCurrentUser();
    } catch (e) {
      throw Exception('Failed to get current user: $e');
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await _datasource.logout();
    } catch (e) {
      throw Exception('Failed to logout: $e');
    }
  }

  @override
  Future<UserData> login({required String pinCode}) async {
    try {
      final user = await _datasource.login(pinCode: pinCode);
      
      if (user == null) {
        throw Exception('Invalid PIN code');
      }
      
      return user;
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  @override
  Future<UserData> register({
    required String name,
    required int age,
    required String job,
    required String sex,
    required String pinCodeHash,
  }) async {
    try {
      return await _datasource.register(
        name: name,
        age: age,
        job: job,
        sex: sex,
        pinCodeHash: pinCodeHash,
      );
    } catch (e) {
      throw Exception('Failed to register: $e');
    }
  }
}
