import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_task/core/router/route_names.dart';
import 'package:secure_task/features/auth/presentation/screens/enter_pin_screen.dart';
import 'package:secure_task/features/auth/presentation/screens/register_pin_screen.dart';
import 'package:secure_task/features/home/presentation/screens/home_screen.dart';
import 'package:secure_task/features/splash/presentation/screens/splash_screen.dart';

class AppRouter {
  static Page<void> _fadePage(GoRouterState state, Widget child) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: RouteNames.splash,
        pageBuilder: (context, state) => _fadePage(state, const SplashScreen()),
      ),
      GoRoute(
        path: '/register',
        name: RouteNames.register,
        pageBuilder: (context, state) =>
            _fadePage(state, const RegisterPinScreen()),
      ),
      GoRoute(
        path: '/login',
        name: RouteNames.login,
        pageBuilder: (context, state) =>
            _fadePage(state, const EnterPinScreen()),
      ),
      GoRoute(
        path: '/home',
        name: RouteNames.home,
        pageBuilder: (context, state) => _fadePage(state, const HomeScreen()),
      ),
    ],
  );
}
