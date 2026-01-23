import 'package:get_it/get_it.dart';
import 'package:secure_task/core/database/app_database/app_database.dart';
import 'package:secure_task/features/auth/data/datasource/auth_datasource.dart';
import 'package:secure_task/features/auth/data/repository/auth_repository_impl.dart';
import 'package:secure_task/features/auth/domain/repository/auth_repository.dart';
import 'package:secure_task/features/auth/domain/use_cases/get_current_user_usecase.dart';
import 'package:secure_task/features/auth/domain/use_cases/login_usecase.dart';
import 'package:secure_task/features/auth/domain/use_cases/logout_usecase.dart';
import 'package:secure_task/features/auth/domain/use_cases/register_usecase.dart';
import 'package:secure_task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:secure_task/features/home/data/datasource/home_datasource.dart';
import 'package:secure_task/features/home/data/repository/home_repository.dart';
import 'package:secure_task/features/home/domain/repository/home_repository.dart';
import 'package:secure_task/features/home/domain/use_cases/get_pinned_notes_usecase.dart';
import 'package:secure_task/features/home/domain/use_cases/get_priority_tasks_usecase.dart';
import 'package:secure_task/features/home/presentation/bloc/home_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  //drift db
  getIt.registerSingleton<AppDatabase>(AppDatabase());

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

  //auth bloc
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      getIt<LoginUseCase>(),
      getIt<LogoutUseCase>(),
      getIt<GetcurrentuserUsecase>(),
      getIt<RegisterUseCase>(),
    ),
  );

  //feature HOME
  //Home datasource
  getIt.registerLazySingleton<HomeDatasource>(
    () => HomeDatasource(getIt<AppDatabase>()),
  );

  //repository
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(getIt<HomeDatasource>()),
  );

  //use-caes
  getIt.registerLazySingleton<GetPriorityTasksUsecase>(
    () => GetPriorityTasksUsecase(getIt<HomeRepository>()),
  );
  getIt.registerLazySingleton<GetPinnedNotesUsecase>(
    () => GetPinnedNotesUsecase(getIt<HomeRepository>()),
  );

  //home bloc
  getIt.registerFactory<HomeBloc>(
    () => HomeBloc(
      getIt<GetPinnedNotesUsecase>(),
      getIt<GetPriorityTasksUsecase>(),
    ),
  );
}
