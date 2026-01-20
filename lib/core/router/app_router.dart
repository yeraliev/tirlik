import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_task/core/router/route_names.dart';
import 'package:secure_task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:secure_task/features/auth/presentation/bloc/go_router_stream.dart';
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

  static GoRouter router(AuthBloc authBloc) => GoRouter(
    initialLocation: '/',
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (context, state) {
      final authStatus = authBloc.state.status;
      final currentPath = state.matchedLocation;

      // Always allow splash screen to show when loading
      if (authStatus == AuthStatus.loading) {
        return currentPath == '/' ? null : '/';
      }

      // Don't redirect if already on splash
      if (currentPath == '/') {
        // Only redirect away from splash if we have a status
        if (authStatus == AuthStatus.initial) return '/register';
        if (authStatus == AuthStatus.registered) return '/login';
        if (authStatus == AuthStatus.authenticated) return '/home';
        return null;
      }

      // Normal redirects for other routes
      if (authStatus == AuthStatus.initial && currentPath != '/register') {
        return '/register';
      }

      if (authStatus == AuthStatus.registered && currentPath != '/login') {
        return '/login';
      }

      if (authStatus == AuthStatus.authenticated && currentPath != '/home') {
        return '/home';
      }

      return null;
    },
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
