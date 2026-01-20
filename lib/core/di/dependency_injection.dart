import 'package:get_it/get_it.dart';
import 'package:secure_task/core/database/app_database/app_database.dart';
import 'package:secure_task/features/auth/data/datasource/auth_datasource.dart';
import 'package:secure_task/features/auth/data/repository/auth_repository_impl.dart';
import 'package:secure_task/features/auth/domain/repository/auth_repository.dart';
import 'package:secure_task/features/auth/domain/use_cases/get_current_user_usecase.dart';
import 'package:secure_task/features/auth/domain/use_cases/login_usecase.dart';
import 'package:secure_task/features/auth/domain/use_cases/logout_usecase.dart';
import 'package:secure_task/features/auth/domain/use_cases/register_usecase.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  //drift db
  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());

  //feature AUTH
  //datasource
  getIt.registerLazySingleton<AuthDatasource>(
    () => AuthDatasource(getIt<AppDatabase>()),
  );

  //repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthDatasource>()),
  );

  //use-cases
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<GetcurrentuserUsecase>(
    () => GetcurrentuserUsecase(getIt<AuthRepository>()),
  );
}
