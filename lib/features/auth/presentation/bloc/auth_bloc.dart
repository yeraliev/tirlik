import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:secure_task/core/database/app_database/app_database.dart';
import 'package:secure_task/core/di/dependency_injection.dart';
import 'package:secure_task/features/auth/domain/use_cases/get_current_user_usecase.dart';
import 'package:secure_task/features/auth/domain/use_cases/login_usecase.dart';
import 'package:secure_task/features/auth/domain/use_cases/logout_usecase.dart';
import 'package:secure_task/features/auth/domain/use_cases/register_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase _registerUseCase;
  final LoginUseCase _loginUseCase;
  final GetcurrentuserUsecase _getCurrentUserUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthBloc()
    : _registerUseCase = getIt<RegisterUseCase>(),
      _loginUseCase = getIt<LoginUseCase>(),
      _getCurrentUserUseCase = getIt<GetcurrentuserUsecase>(),
      _logoutUseCase = getIt<LogoutUseCase>(),
      super(AuthState(status: AuthStatus.loading)) {
    on<RegisterWithPin>(_onRegister);
    on<LoginWithPin>(_onLogin);
    on<GetCurrentUser>(_onGetCurrentUser);
    on<LogoutRequested>(_onLogout);
  }

  Future<void> _onRegister(
    RegisterWithPin event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      final user = await _registerUseCase.call(
        name: event.name,
        age: event.age,
        job: event.job,
        sex: event.sex,
        pinCode: event.pin,
      );
      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.initial, error: e.toString()));
    }
  }

  Future<void> _onLogin(LoginWithPin event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      final user = await _loginUseCase.call(pinCode: event.pin);
      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.registered, error: e.toString()));
    }
  }

  Future<void> _onGetCurrentUser(
    GetCurrentUser event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final user = await _getCurrentUserUseCase.call();
      if (user != null) {
        emit(state.copyWith(status: AuthStatus.registered, user: user));
      } else {
        emit(state.copyWith(status: AuthStatus.initial));
      }
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.initial, error: e.toString()));
    }
  }

  Future<void> _onLogout(LogoutRequested event, Emitter<AuthState> emit) async {
    try {
      await _logoutUseCase.call();
      emit(AuthState.initial());
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
