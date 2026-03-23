import 'package:dio/dio.dart';

/// Central Dio instance for API calls.
/// Configure interceptors, base URL, and timeouts here.
class DioClient {
  DioClient._();

  static Dio create() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    // Add interceptors for logging, auth, retries, etc. as needed
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );

    return dio;
  }
}
