import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/live_score_repository.dart';
import 'live_score_event.dart';
import 'live_score_state.dart';

class LiveScoreBloc extends Bloc<LiveScoreEvent, LiveScoreState> {
  final LiveScoreRepository repository;
  Timer? _timer;

  LiveScoreBloc({required this.repository}) : super(LiveScoreLoading()) {
    on<FetchLiveScores>(_onFetchLiveScores);
    on<RefreshLiveScores>(_onRefreshLiveScores);
    on<SelectLeague>(_onSelectLeague);
    _startAutoRefresh();
  }

  Future<void> _onFetchLiveScores(FetchLiveScores event, Emitter<LiveScoreState> emit) async {
    emit(LiveScoreLoading());
    try {
      final scores = await repository.fetchLiveScores();
      emit(LiveScoreLoaded(events: scores));
    } catch (e) {
      emit(LiveScoreError(message: e.toString()));
    }
  }

  Future<void> _onRefreshLiveScores(RefreshLiveScores event, Emitter<LiveScoreState> emit) async {
    emit(LiveScoreLoading());
    if (state is LiveScoreLoaded) {
      try {
        final scores = await repository.fetchLiveScores();
        emit(LiveScoreLoaded(
          events: scores,
          selectedLeagueId: (state as LiveScoreLoaded).selectedLeagueId,
        ));
      } catch (e) {
        emit(LiveScoreError(message: e.toString()));
      }
    } else {
      add(const FetchLiveScores());
    }
  }

  Future<void> _onSelectLeague(SelectLeague event, Emitter<LiveScoreState> emit) async {
    emit(LiveScoreLoading());
    try {
      final scores = await repository.fetchLiveScores(leagueId: event.leagueId);
      emit(LiveScoreLoaded(events: scores));
    } catch (e) {
      emit(LiveScoreError(message: e.toString()));
    }
  }

  Future<void> _startAutoRefresh() async {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      add(const RefreshLiveScores());
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
