part of 'home_bloc.dart';

enum HomeStatus { loading, loaded }

class HomeState {
  final HomeStatus status;
  final List<Task>? tasks;
  final List<Note>? notes;
  final String? error;

  HomeState({required this.status, this.tasks, this.notes, this.error});

  HomeState copyWith({
    HomeStatus? status,
    List<Task>? tasks,
    List<Note>? notes,
    String? error,
  }) {
    return HomeState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      notes: notes ?? this.notes,
      error: error,
    );
  }
}
