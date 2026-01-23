import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:secure_task/core/database/app_database/app_database.dart';
import 'package:secure_task/features/home/domain/use_cases/get_pinned_notes_usecase.dart';
import 'package:secure_task/features/home/domain/use_cases/get_priority_tasks_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetPriorityTasksUsecase _getPriorityTasksUsecase;
  final GetPinnedNotesUsecase _getPinnedNotesUsecase;

  HomeBloc(this._getPinnedNotesUsecase, this._getPriorityTasksUsecase)
    : super(HomeState(status: HomeStatus.loading)) {
    on<GetTasksEvent>(_onGetTasksEvent);
    on<GetNotesEvent>(_onGetNotesEvent);
  }

  Future<void> _onGetTasksEvent(
    GetTasksEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(HomeState(status: HomeStatus.loading));
      final tasks = await _getPriorityTasksUsecase.call();
      emit(HomeState(status: HomeStatus.loaded, tasks: tasks));
    } catch (e) {
      emit(HomeState(status: HomeStatus.loading, error: e.toString()));
    }
  }

  Future<void> _onGetNotesEvent(
    GetNotesEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(HomeState(status: HomeStatus.loading));
      final notes = await _getPinnedNotesUsecase.call();
      emit(HomeState(status: HomeStatus.loaded, notes: notes));
    } catch (e) {
      emit(HomeState(status: HomeStatus.loading, error: e.toString()));
    }
  }
}
