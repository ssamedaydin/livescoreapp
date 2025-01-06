import 'package:equatable/equatable.dart';
import '../../../domain/models/event_model.dart';

abstract class LiveScoreState extends Equatable {
  const LiveScoreState();

  @override
  List<Object?> get props => [];
}

class LiveScoreLoading extends LiveScoreState {}

class LiveScoreLoaded extends LiveScoreState {
  final List<EventModel> events;
  final String? selectedLeagueId;

  const LiveScoreLoaded({
    required this.events,
    this.selectedLeagueId,
  });

  @override
  List<Object?> get props => [events, selectedLeagueId];
}

class LiveScoreError extends LiveScoreState {
  final String message;

  const LiveScoreError({required this.message});

  @override
  List<Object?> get props => [message];
}
