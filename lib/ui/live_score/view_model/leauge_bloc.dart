import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/leauges_repository.dart';
import '../../../domain/models/leauges_model.dart';
import 'leauge_event.dart';
import 'leauge_state.dart';

class LeagueBloc extends Bloc<LeagueEvent, LeagueState> {
  final LeagueRepository repository;

  LeagueBloc({required this.repository}) : super(LeagueLoading()) {
    on<FetchLeagues>(_onFetchLeagues);
    on<SelectLeagueLx>(_onSelectLeague);
  }

  Future<void> _onFetchLeagues(FetchLeagues event, Emitter<LeagueState> emit) async {
    emit(LeagueLoading());
    try {
      final leagues = await repository.fetchLeagues();

      final allLeagues = [
        LeaguesModel(
          leagueKey: -1,
          leagueName: "All",
          leagueLogo: "",
        ),
        ...leagues,
      ];

      emit(LeagueLoaded(leagues: allLeagues, selectedLeagueId: "-1"));
    } catch (e) {
      emit(LeagueError(message: e.toString()));
    }
  }

  Future<void> _onSelectLeague(SelectLeagueLx event, Emitter<LeagueState> emit) async {
    if (state is LeagueLoaded) {
      final currentState = state as LeagueLoaded;
      emit(LeagueLoaded(
        leagues: currentState.leagues,
        selectedLeagueId: event.leagueId,
      ));
    }
  }
}
