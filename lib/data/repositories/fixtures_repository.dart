import 'package:livescoreapp/utils/api_constants.dart';
import '../../domain/models/event_model.dart';
import '../services/api_client.dart';

abstract class FixturesRepository {
  Future<List<EventModel>> fetchFixtures({
    required String from,
    required String to,
    String? leagueId,
  });
}

class FixturesRepositoryImpl implements FixturesRepository {
  final ApiClient apiClient;

  FixturesRepositoryImpl({required this.apiClient});

  @override
  Future<List<EventModel>> fetchFixtures({
    required String from,
    required String to,
    String? leagueId,
  }) async {
    try {
      final response = await apiClient.dio.get(
        '${ApiConstants.fixtures}&from=$from&to=$to${leagueId != null ? "&leagueId=$leagueId" : ""}${ApiConstants.apiKey}',
      );
      final data = (response.data['result'] as List?) ?? [];
      final limitedData = data.take(20).toList();
      return limitedData.map((json) => EventModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception("No fixtures available for the selected criteria.");
    }
  }
}
