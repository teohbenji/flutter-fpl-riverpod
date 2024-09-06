import 'package:dio/dio.dart';

class DioService {
  late Dio _dio;

  DioService() {
    _dio = Dio(BaseOptions(
      baseUrl: "https://fantasy.premierleague.com/",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 5),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'appliation/json',
      },
    ));
  }

  // Generic GET request method
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow; // Re-throw the exception to handle it later
    }
  }
}
