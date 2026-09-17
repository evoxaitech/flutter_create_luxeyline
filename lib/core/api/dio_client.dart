import 'package:dio/dio.dart';
import 'api_config.dart';
import 'token_storage.dart';

/// Shared Dio — har API call mein token automatically lag jaata hai.
class DioClient {
  static final Dio dio = _create();

  static Dio _create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: {'Content-Type': 'application/json'},
        validateStatus: (status) => true,
      ),
    );

    // Har request se pehle token header mein daal do
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await TokenStorage.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
      ),
    );

    return dio;
  }
}
