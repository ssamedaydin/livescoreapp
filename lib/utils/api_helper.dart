import 'api_constants.dart';

class ApiHelper {
  static String buildUrl(String endpoint, {Map<String, String>? queryParameters}) {
    final uri = Uri.parse("${ApiConstants.baseUrl}$endpoint&${ApiConstants.apiKey}").replace();
    return uri.toString();
  }
}
