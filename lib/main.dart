import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:secure_task/core/di/dependency_injection.dart';
import 'package:secure_task/core/locale/locale_cubit.dart';
import 'package:secure_task/core/router/app_router.dart';
import 'package:secure_task/core/theme/app_theme.dart';
import 'package:secure_task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:secure_task/features/home/presentation/bloc/home_bloc.dart';
import 'package:secure_task/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupDependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final localeCubit = LocaleCubit();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: localeCubit..init()),
        BlocProvider.value(value: getIt<AuthBloc>()),
        BlocProvider.value(value: getIt<HomeBloc>()),
      ],
      child: const _AppView(),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        return MaterialApp.router(
          routerConfig: AppRouter.router(context.read<AuthBloc>()),
          debugShowCheckedModeBanner: false,
          title: 'Secure Task',
          theme: AppTheme.lightTheme,
          locale: locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en'), Locale('ru'), Locale('kk')],
        );
      },
    );
  }
}
