import 'package:dio/dio.dart';
import 'api_config.dart';

class AuthService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {'Content-Type': 'application/json'},
      validateStatus: (status) => true,
    ),
  );

  // SIGNUP — naya account (OTP email par jaata hai)
  Future<Map<String, dynamic>> signup({
    required String fullName,
    required String phoneNumber,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        ApiConfig.signup,
        data: {
          'fullName': fullName,
          'phoneNumber': phoneNumber,
          'email': email,
          'password': password,
        },
      );

      final code = response.statusCode ?? 0;
      if (code >= 200 && code < 300) {
        return {'success': true, 'data': response.data};
      }
      return {'success': false, 'message': _err(response.data, code)};
    } on DioException catch (e) {
      return {
        'success': false,
        'message': 'Network error: ${e.message ?? 'please try again'}',
      };
    }
  }

  String _err(dynamic data, int code) {
    if (data is Map) {
      return data['message']?.toString() ??
          data['error']?.toString() ??
          'Something went wrong (code $code)';
    }
    return 'Something went wrong (code $code)';
  }
}
