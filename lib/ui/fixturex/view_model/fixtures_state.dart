import 'package:equatable/equatable.dart';
import '../../../domain/models/event_model.dart';

abstract class FixturesState extends Equatable {
  const FixturesState();

  @override
  List<Object?> get props => [];
}

class FixturesLoading extends FixturesState {}

class FixturesLoaded extends FixturesState {
  final List<EventModel> fixtures;

  const FixturesLoaded({required this.fixtures});

  @override
  List<Object?> get props => [fixtures];
}

class FixturesError extends FixturesState {
  final String message;

  const FixturesError({required this.message});

  @override
  List<Object?> get props => [message];
}
