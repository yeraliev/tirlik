import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_task/core/di/dependency_injection.dart';
import 'package:secure_task/core/router/app_router.dart';
import 'package:secure_task/core/theme/app_theme.dart';
import 'package:secure_task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:secure_task/features/home/presentation/bloc/home_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<AuthBloc>()),
        BlocProvider.value(value: getIt<HomeBloc>()),
      ],
      child: Builder(
        builder: (context) {
          final authBloc = context.read<AuthBloc>();

          return MaterialApp.router(
            routerConfig: AppRouter.router(authBloc),
            debugShowCheckedModeBanner: false,
            title: 'Secure Task',
            theme: AppTheme.lightTheme,
          );
        },
      ),
    );
  }
}
