import 'package:livescoreapp/utils/api_constants.dart';

import '../../domain/models/leauges_model.dart';
import '../services/api_client.dart';

abstract class LeagueRepository {
  Future<List<LeaguesModel>> fetchLeagues();
}

class LeagueRepositoryImpl implements LeagueRepository {
  final ApiClient apiClient;

  LeagueRepositoryImpl({required this.apiClient});

  List<LeaguesModel>? _cachedLeagues;
  //ünlü ligler
  static const List<int> selectedLeagueKeys = [
    152, // premier League
    322, // Super Lig
    302, // la Liga
    168, // Ligue 1
  ];

  @override
  Future<List<LeaguesModel>> fetchLeagues() async {
    if (_cachedLeagues != null) {
      return _cachedLeagues!;
    }

    try {
      final response = await apiClient.dio.get(
        '${ApiConstants.leagues}${ApiConstants.apiKey}',
      );
      final List data = response.data['result'] ?? [];

      _cachedLeagues = data
          .map((json) => LeaguesModel.fromJson(json))
          .where((league) => selectedLeagueKeys.contains(int.tryParse(league.leagueKey.toString())))
          .toList();

      return _cachedLeagues!;
    } catch (e) {
      throw Exception('Failed to fetch leagues: $e');
    }
  }
}
