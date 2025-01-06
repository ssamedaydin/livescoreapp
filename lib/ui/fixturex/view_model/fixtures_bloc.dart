import '../../../data/repositories/fixtures_repository.dart';
import 'fixtures_event.dart';
import 'fixtures_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FixturesBloc extends Bloc<FixturesEvent, FixturesState> {
  final FixturesRepository repository;

  FixturesBloc({required this.repository}) : super(FixturesLoading()) {
    on<FetchFixtures>(_onFetchFixtures);
    on<SelectLeagueFx>(_onSelectLeagueFx);
  }

  Future<void> _onFetchFixtures(FetchFixtures event, Emitter<FixturesState> emit) async {
    emit(FixturesLoading());
    try {
      final fixtures = await repository.fetchFixtures(
        from: event.from,
        to: event.to,
      );
      if (fixtures.isEmpty) {
        emit(FixturesError(message: "No fixtures available for the selected date."));
      } else {
        emit(FixturesLoaded(fixtures: fixtures));
      }
    } catch (e) {
      emit(FixturesError(message: e.toString()));
    }
  }

  Future<void> _onSelectLeagueFx(SelectLeagueFx event, Emitter<FixturesState> emit) async {
    emit(FixturesLoading());
    try {
      final fixtures = await repository.fetchFixtures(
        leagueId: event.leagueId,
        from: DateTime.now().toIso8601String().split('T')[0],
        to: DateTime.now().toIso8601String().split('T')[0],
      );
      if (fixtures.isEmpty) {
        emit(FixturesError(message: "No fixtures available for the selected league."));
      } else {
        emit(FixturesLoaded(fixtures: fixtures));
      }
    } catch (e) {
      emit(FixturesError(message: e.toString()));
    }
  }
}
