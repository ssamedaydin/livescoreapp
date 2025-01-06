import 'package:equatable/equatable.dart';

abstract class FixturesEvent extends Equatable {
  const FixturesEvent();

  @override
  List<Object?> get props => [];
}

class FetchFixtures extends FixturesEvent {
  final String from;
  final String to;

  const FetchFixtures({required this.from, required this.to});

  @override
  List<Object?> get props => [from, to];
}

class SelectLeagueFx extends FixturesEvent {
  final String leagueId;

  const SelectLeagueFx({required this.leagueId});

  @override
  List<Object?> get props => [leagueId];
}
