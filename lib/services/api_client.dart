import 'package:dio/dio.dart';

class ApiClient {
  static const baseUrl = 'http://45.129.87.38:6065';
  final Dio dio;

  ApiClient._(this.dio);

  factory ApiClient({String? token}) {
    final options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    );
    final dio = Dio(options);
    if (token != null && token.isNotEmpty) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return ApiClient._(dio);
  }
}
