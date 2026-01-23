part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class GetTasksEvent extends HomeEvent {}

class GetNotesEvent extends HomeEvent {}