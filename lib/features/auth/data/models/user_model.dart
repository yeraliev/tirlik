import 'package:secure_task/features/auth/domain/entities/user.dart';

class UserModel extends User{
  UserModel({required super.age, required super.job, required super.name, required super.sex, required super.id, required super.pinCodeHash});
}