part of 'auth_bloc.dart';

enum AuthStatus { initial, registered, authenticated, loading }

class AuthState {
  final AuthStatus status;
  final UserData? user;
  final String? error;

  const AuthState({
    required this.status,
    this.user,
    this.error,
  });

  factory AuthState.initial() => const AuthState(status: AuthStatus.initial);

  AuthState copyWith({
    AuthStatus? status,
    UserData? user,
    String? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error,
    );
  }
}
