import 'package:secure_task/features/auth/domain/entities/user.dart';
import 'package:secure_task/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{
  @override
  Future<User?> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<void> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  Future<User> login({required String pinCode}) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<User> register({required String name, required int age, required String job, required String sex, required String pinCode}) {
    // TODO: implement register
    throw UnimplementedError();
  }
  
}