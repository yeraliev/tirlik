part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class GetTasksEvent extends HomeEvent {}

class GetNotesEvent extends HomeEvent {}

class AddNoteEvent extends HomeEvent {
  final String title;
  final String content;
  final int userId;
  final bool isPinned;

  AddNoteEvent({
    required this.title,
    required this.content,
    required this.userId,
    this.isPinned = false,
  });
}

class AddTaskEvent extends HomeEvent {
  final String title;
  final String description;
  final int taskGroupId;
  final int userId;
  final DateTime? dueDate;
  final int priority;

  AddTaskEvent({
    required this.title,
    required this.description,
    required this.taskGroupId,
    required this.userId,
    this.dueDate,
    this.priority = 0,
  });
}

class GetTaskGroupsEvent extends HomeEvent {}
