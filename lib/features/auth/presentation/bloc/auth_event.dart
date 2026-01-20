part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class RegisterWithPin extends AuthEvent {
  final String name;
  final int age;
  final String job;
  final String sex;
  final String pin;
  RegisterWithPin(this.pin, this.name, this.age, this.job, this.sex);
}

class LoginWithPin extends AuthEvent {
  final String pin;
  LoginWithPin(this.pin);
}

class GetCurrentUser extends AuthEvent {}

class LogoutRequested extends AuthEvent {}
