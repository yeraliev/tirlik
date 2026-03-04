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

class UpdateTaskEvent extends HomeEvent {
  final int taskId;
  final String? title;
  final String? description;
  final int? taskGroupId;
  final int? priority;
  final DateTime? dueDate;
  final bool? isCompleted;

  UpdateTaskEvent({
    required this.taskId,
    this.title,
    this.description,
    this.taskGroupId,
    this.priority,
    this.dueDate,
    this.isCompleted,
  });
}

class DeleteTaskEvent extends HomeEvent {
  final int taskId;

  DeleteTaskEvent({required this.taskId});
}

class GetAllTasksEvent extends HomeEvent {
  final DateTime? dateFilter;
  final int? priorityFilter;

  GetAllTasksEvent({this.dateFilter, this.priorityFilter});
}

class SearchNotesEvent extends HomeEvent {
  final String query;

  SearchNotesEvent({this.query = ''});
}

class CreateTaskGroupEvent extends HomeEvent {
  final String name;
  final String color;
  final int userId;
  final String? icon;

  CreateTaskGroupEvent({
    required this.name,
    required this.color,
    required this.userId,
    this.icon,
  });
}

class UpdateNoteEvent extends HomeEvent {
  final int noteId;
  final String? title;
  final String? content;
  final bool? isPinned;

  UpdateNoteEvent({
    required this.noteId,
    this.title,
    this.content,
    this.isPinned,
  });
}
