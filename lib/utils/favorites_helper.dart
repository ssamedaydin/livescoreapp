import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livescoreapp/utils/strings.dart';

import '../domain/models/event_model.dart';
import '../ui/favorite_matches/view_model/favorite_bloc.dart';
import '../ui/favorite_matches/view_model/favorite_event.dart';
import '../ui/favorite_matches/view_model/favorite_state.dart';

void handleFavorites(BuildContext context, EventModel event) {
  final favoritesBloc = context.read<FavoritesBloc>();
  final currentState = favoritesBloc.state;

  if (currentState is FavoritesLoaded) {
    final currentFavorites = currentState.favorites;

    if (currentFavorites.any((fav) => fav.eventKey == event.eventKey)) {
      favoritesBloc.add(RemoveFromFavorites(event: event, context: context));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "${event.eventHomeTeam} vs ${event.eventAwayTeam} removed from favorites.",
          ),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      favoritesBloc.add(AddToFavorites(event: event, context: context));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "${event.eventHomeTeam} vs ${event.eventAwayTeam} added to favorites.",
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(AppStrings.unableUpdateFav),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
