import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:secure_task/core/database/app_database/app_database.dart';
import 'package:secure_task/features/home/domain/use_cases/add_note_usecase.dart';
import 'package:secure_task/features/home/domain/use_cases/add_task_usecase.dart';
import 'package:secure_task/features/home/domain/use_cases/get_pinned_notes_usecase.dart';
import 'package:secure_task/features/home/domain/use_cases/get_priority_tasks_usecase.dart';
import 'package:secure_task/features/home/domain/use_cases/get_task_groups_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetPriorityTasksUsecase _getPriorityTasksUsecase;
  final GetPinnedNotesUsecase _getPinnedNotesUsecase;
  final AddTaskUsecase _addTaskUsecase;
  final AddNoteUsecase _addNoteUsecase;
  final GetTaskGroupsUsecase _getTaskGroupsUsecase;

  HomeBloc(
    this._getPinnedNotesUsecase,
    this._getPriorityTasksUsecase,
    this._addTaskUsecase,
    this._addNoteUsecase,
    this._getTaskGroupsUsecase,
  ) : super(HomeState(status: HomeStatus.loading)) {
    on<GetTasksEvent>(_onGetTasksEvent);
    on<GetNotesEvent>(_onGetNotesEvent);
    on<AddTaskEvent>(_onAddTaskEvent);
    on<AddNoteEvent>(_onAddNoteEvent);
    on<GetTaskGroupsEvent>(_onGetTaskGroupsEvent);
  }

  Future<void> _onGetTasksEvent(
    GetTasksEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));
      final tasks = await _getPriorityTasksUsecase.call();
      emit(state.copyWith(status: HomeStatus.loaded, tasks: tasks));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.error, error: e.toString()));
    }
  }

  Future<void> _onGetNotesEvent(
    GetNotesEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));
      final notes = await _getPinnedNotesUsecase.call();
      emit(state.copyWith(status: HomeStatus.loaded, notes: notes));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.error, error: e.toString()));
    }
  }

  Future<void> _onAddTaskEvent(
    AddTaskEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));
      await _addTaskUsecase.call(
        title: event.title,
        description: event.description,
        taskGroupId: event.taskGroupId,
        userId: event.userId,
        priority: event.priority,
        dueDate: event.dueDate,
      );

      //fetch updated tasks to keep UI in sync
      final updatedTasks = await _getPriorityTasksUsecase.call();
      emit(state.copyWith(status: HomeStatus.loaded, tasks: updatedTasks));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.error, error: e.toString()));
    }
  }

  Future<void> _onAddNoteEvent(
    AddNoteEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));
      await _addNoteUsecase.call(
        title: event.title,
        content: event.content,
        userId: event.userId,
        isPinned: event.isPinned,
      );

      //fetch updated notes
      final updatedNotes = await _getPinnedNotesUsecase.call();
      emit(state.copyWith(status: HomeStatus.loaded, notes: updatedNotes));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.error, error: e.toString()));
    }
  }

  Future<void> _onGetTaskGroupsEvent(
    GetTaskGroupsEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));
      final taskGroups = await _getTaskGroupsUsecase.call();
      emit(state.copyWith(status: HomeStatus.loaded, taskGroups: taskGroups));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.error, error: e.toString()));
    }
  }
}
