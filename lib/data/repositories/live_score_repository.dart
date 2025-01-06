import 'dart:developer';
import 'package:livescoreapp/utils/api_constants.dart';

import '../../domain/models/event_model.dart';
import '../services/api_client.dart';

abstract class LiveScoreRepository {
  Future<List<EventModel>> fetchLiveScores({String? leagueId});
}

class LiveScoreRepositoryImpl implements LiveScoreRepository {
  final ApiClient apiClient;

  LiveScoreRepositoryImpl({required this.apiClient});

  @override
  Future<List<EventModel>> fetchLiveScores({String? leagueId}) async {
    try {
      final response = await apiClient.dio.get(
        '${ApiConstants.liveScores}&${leagueId != null ? '&leagueId=$leagueId' : ''}${ApiConstants.apiKey}',
      );
      log('API Response: ${response.data}');
      if (response.data['result'] == null || (response.data['result'] as List).isEmpty) {
        return [];
      }
      final data = response.data['result'] as List;
      return data.map((json) => EventModel.fromJson(json)).toList();
    } catch (e) {
      throw Future.error(e.toString());
    }
  }
}
