part of 'home_bloc.dart';

enum HomeStatus { loading, loaded, error }

class HomeState {
  final HomeStatus status;
  final List<Task>? tasks;
  final List<Note>? notes;
  final List<TaskGroup>? taskGroups;
  final String? error;
  final List<Task>? allTasks;
  final List<Note>? searchedNotes;
  final DateTime? taskDateFilter;
  final int? taskPriorityFilter;

  HomeState({
    required this.status,
    this.tasks,
    this.notes,
    this.error,
    this.taskGroups,
    this.allTasks,
    this.searchedNotes,
    this.taskDateFilter,
    this.taskPriorityFilter,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<Task>? tasks,
    List<Note>? notes,
    List<TaskGroup>? taskGroups,
    String? error,
    List<Task>? allTasks,
    List<Note>? searchedNotes,
    DateTime? taskDateFilter,
    int? taskPriorityFilter,
    bool clearTaskDateFilter = false,
    bool clearTaskPriorityFilter = false,
  }) {
    return HomeState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      notes: notes ?? this.notes,
      taskGroups: taskGroups ?? this.taskGroups,
      error: error,
      allTasks: allTasks ?? this.allTasks,
      searchedNotes: searchedNotes ?? this.searchedNotes,
      taskDateFilter: clearTaskDateFilter
          ? null
          : taskDateFilter ?? this.taskDateFilter,
      taskPriorityFilter: clearTaskPriorityFilter
          ? null
          : taskPriorityFilter ?? this.taskPriorityFilter,
    );
  }
}
