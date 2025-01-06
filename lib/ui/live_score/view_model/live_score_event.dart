import 'package:equatable/equatable.dart';

abstract class LiveScoreEvent extends Equatable {
  const LiveScoreEvent();

  @override
  List<Object?> get props => [];
}

class FetchLiveScores extends LiveScoreEvent {
  const FetchLiveScores();
}

class RefreshLiveScores extends LiveScoreEvent {
  const RefreshLiveScores();
}

class SelectLeague extends LiveScoreEvent {
  final String leagueId;

  const SelectLeague({required this.leagueId});

  @override
  List<Object?> get props => [leagueId];
}
