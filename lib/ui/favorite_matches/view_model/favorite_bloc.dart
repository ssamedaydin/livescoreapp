import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:livescoreapp/ui/favorite_matches/view_model/favorite_event.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/models/event_model.dart';
import 'favorite_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<AddToFavorites>(_onAddToFavorites);
    on<RemoveFromFavorites>(_onRemoveFromFavorites);
  }

  Future<void> _onLoadFavorites(LoadFavorites event, Emitter<FavoritesState> emit) async {
    emit(FavoritesLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesString = prefs.getString('favorites');
      if (favoritesString != null) {
        final favoritesJson = json.decode(favoritesString) as List<dynamic>;
        final favorites = favoritesJson.map((e) => EventModel.fromJson(e as Map<String, dynamic>)).toList();
        emit(FavoritesLoaded(favorites: favorites));
      } else {
        emit(FavoritesLoaded(favorites: []));
      }
    } catch (e) {
      emit(FavoritesError(message: 'Error loading favorites: $e'));
    }
  }

  Future<void> _onAddToFavorites(AddToFavorites event, Emitter<FavoritesState> emit) async {
    if (state is FavoritesLoaded) {
      final currentFavorites = (state as FavoritesLoaded).favorites;

      if (currentFavorites.any((favorite) => favorite.eventKey == event.event.eventKey)) {
        return;
      }

      final updatedFavorites = List<EventModel>.from(currentFavorites)..add(event.event);

      final prefs = await SharedPreferences.getInstance();
      final favoritesString = json.encode(updatedFavorites.map((e) => e.toJson()).toList());
      await prefs.setString('favorites', favoritesString);

      emit(FavoritesLoaded(favorites: updatedFavorites));
    }
  }

  Future<void> _onRemoveFromFavorites(RemoveFromFavorites event, Emitter<FavoritesState> emit) async {
    if (state is FavoritesLoaded) {
      final currentFavorites = (state as FavoritesLoaded).favorites;

      if (!currentFavorites.any((favorite) => favorite.eventKey == event.event.eventKey)) {
        return;
      }

      final updatedFavorites = List<EventModel>.from(currentFavorites)..removeWhere((favorite) => favorite.eventKey == event.event.eventKey);

      final prefs = await SharedPreferences.getInstance();
      final favoritesString = json.encode(updatedFavorites.map((e) => e.toJson()).toList());
      await prefs.setString('favorites', favoritesString);

      emit(FavoritesLoaded(favorites: updatedFavorites));
    }
  }
}
