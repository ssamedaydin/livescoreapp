import 'package:equatable/equatable.dart';

abstract class LeagueEvent extends Equatable {
  const LeagueEvent();

  @override
  List<Object?> get props => [];
}

class FetchLeagues extends LeagueEvent {
  const FetchLeagues();
}

class SelectLeagueLx extends LeagueEvent {
  final String leagueId;

  const SelectLeagueLx({required this.leagueId});

  @override
  List<Object?> get props => [leagueId];
}
