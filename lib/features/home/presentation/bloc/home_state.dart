part of 'home_bloc.dart';

enum HomeStatus { loading, loaded, error }

class HomeState {
  final HomeStatus status;
  final List<Task>? tasks;
  final List<Note>? notes;
  final List<TaskGroup>? taskGroups;
  final String? error;

  HomeState({
    required this.status,
    this.tasks,
    this.notes,
    this.error,
    this.taskGroups,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<Task>? tasks,
    List<Note>? notes,
    List<TaskGroup>? taskGroups,
    String? error,
  }) {
    return HomeState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      notes: notes ?? this.notes,
      taskGroups: taskGroups ?? this.taskGroups,
      error: error,
    );
  }
}
