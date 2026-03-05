import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_task/core/router/route_names.dart';
import 'package:secure_task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:secure_task/core/router/go_router_stream.dart';
import 'package:secure_task/features/auth/presentation/screens/enter_pin_screen.dart';
import 'package:secure_task/features/auth/presentation/screens/register_pin_screen.dart';
import 'package:secure_task/features/home/presentation/screens/add_note_screen.dart';
import 'package:secure_task/features/home/presentation/screens/add_task_screen.dart';
import 'package:secure_task/features/home/presentation/screens/all_notes_screen.dart';
import 'package:secure_task/features/home/presentation/screens/all_tasks_screen.dart';
import 'package:secure_task/features/home/presentation/screens/edit_note_screen.dart';
import 'package:secure_task/features/home/presentation/screens/home_screen.dart';
import 'package:secure_task/features/splash/presentation/screens/splash_screen.dart';

class AppRouter {
  static GoRouter? _router;

  static void reset() {
    _router = null;
  }

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

  static GoRouter router(AuthBloc authBloc) {
    return _router ??= GoRouter(
      initialLocation: '/',
      refreshListenable: GoRouterRefreshStream(authBloc.stream),
      redirect: (context, state) {
        final authStatus = authBloc.state.status;
        final currentPath = state.matchedLocation;

        //Always allow splash screen to show when loading
        if (authStatus == AuthStatus.loading) {
          return currentPath == '/' ? null : '/';
        }

        //not redirect if already on splash
        if (currentPath == '/') {
          //Only redirect away from splash if status is not loading
          if (authStatus == AuthStatus.initial) return '/register';
          if (authStatus == AuthStatus.registered) return '/login';
          if (authStatus == AuthStatus.authenticated) return '/home';
          return null;
        }

        //Normal redirects for other routes
        if (authStatus == AuthStatus.initial && currentPath != '/register') {
          return '/register';
        }

        if (authStatus == AuthStatus.registered && currentPath != '/login') {
          return '/login';
        }

        if (authStatus == AuthStatus.authenticated &&
            currentPath == '/register') {
          return '/home';
        }

        if (authStatus == AuthStatus.authenticated && currentPath == '/login') {
          return '/home';
        }

        return null;
      },
      routes: [
        GoRoute(
          path: '/',
          name: RouteNames.splash,
          pageBuilder: (context, state) =>
              _fadePage(state, const SplashScreen()),
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
        GoRoute(
          path: '/addTask',
          name: RouteNames.addTask,
          pageBuilder: (context, state) =>
              _fadePage(state, const AddTaskScreen()),
        ),
        GoRoute(
          path: '/addNote',
          name: RouteNames.addNote,
          pageBuilder: (context, state) =>
              _fadePage(state, const AddNoteScreen()),
        ),
        GoRoute(
          path: '/allTasks',
          name: RouteNames.allTasks,
          pageBuilder: (context, state) =>
              _fadePage(state, const AllTasksScreen()),
        ),
        GoRoute(
          path: '/allNotes',
          name: RouteNames.allNotes,
          pageBuilder: (context, state) =>
              _fadePage(state, const AllNotesScreen()),
        ),
        GoRoute(
          path: '/editNote',
          name: RouteNames.editNote,
          pageBuilder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;
            return _fadePage(
              state,
              EditNoteScreen(
                noteId: extra['noteId'] as int,
                initialTitle: extra['title'] as String,
                initialContent: extra['content'] as String,
                initialIsPinned: extra['isPinned'] as bool,
              ),
            );
          },
        ),
      ],
    );
  }
}
