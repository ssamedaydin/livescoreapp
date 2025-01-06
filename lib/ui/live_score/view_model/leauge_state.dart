import 'package:equatable/equatable.dart';

import '../../../domain/models/leauges_model.dart';

abstract class LeagueState extends Equatable {
  const LeagueState();

  @override
  List<Object?> get props => [];
}

class LeagueLoading extends LeagueState {}

class LeagueLoaded extends LeagueState {
  final List<LeaguesModel> leagues;
  final String? selectedLeagueId;

  const LeagueLoaded({
    required this.leagues,
    this.selectedLeagueId,
  });

  @override
  List<Object?> get props => [leagues, selectedLeagueId];
}

class LeagueError extends LeagueState {
  final String message;

  const LeagueError({required this.message});

  @override
  List<Object?> get props => [message];
}
