import 'dart:developer';
import 'package:dio/dio.dart';

class ApiClient {

  static final ApiClient _instance = ApiClient._internal();

  late final Dio dio;

  factory ApiClient() => _instance;

  ApiClient._internal() {
    dio = _createDio();
  }

  Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://apiv2.allsportsapi.com/football',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _handleRequest,
        onResponse: _handleResponse,
        onError: _handleError,
      ),
    );

    return dio;
  }

  void _handleRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('Request: ${options.method} ${options.uri}');
    //options.headers['APIkey'] = '50c3a7e5612adf334093733773e7f220e32a875d3462661f16e6d899594c2b35';
    handler.next(options);
  }

  void _handleResponse(Response response, ResponseInterceptorHandler handler) {
    log('Response: ${response.statusCode} - ${response.data}');
    handler.next(response);
  }

  void _handleError(DioException error, ErrorInterceptorHandler handler) {
    log('Error: ${error.message}');

    if (error.response?.statusCode == 401) {
      log('Unauthorized! Please check your token.');
    } else if (error.type == DioExceptionType.connectionTimeout) {
      log('No Internet connection. Please check your network.');
    } else if (error.type == DioExceptionType.connectionError) {
      log('Connection timeout! Please check your internet connection.');
    } else if (error.type == DioExceptionType.receiveTimeout) {
      log('Receive timeout! Server is taking too long to respond.');
    } else if (error.type == DioExceptionType.unknown) {
      log('Unknown error occurred: ${error.error}');
    }
    handler.next(error);
  }
}
