import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/event_model.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class AddToFavorites extends FavoritesEvent {
  final EventModel event;
  final BuildContext context;

  const AddToFavorites({required this.event, required this.context});

  @override
  List<Object?> get props => [event, context];
}

class RemoveFromFavorites extends FavoritesEvent {
  final EventModel event;
  final BuildContext context;

  const RemoveFromFavorites({required this.event, required this.context});

  @override
  List<Object?> get props => [event, context];
}

class LoadFavorites extends FavoritesEvent {}
