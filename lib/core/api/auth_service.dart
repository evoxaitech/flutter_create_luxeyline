import 'package:dio/dio.dart';
import 'api_config.dart';
import 'dio_client.dart';
import 'token_storage.dart';

class AuthService {
  final Dio _dio = DioClient.dio;

  // SIGNUP — naya account
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

  // LOGIN — token save karta hai
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        ApiConfig.login,
        data: {'email': email, 'password': password},
      );
      final code = response.statusCode ?? 0;
      if (code >= 200 && code < 300) {
        // Token dhoondo (naam kuch bhi ho sakta hai)
        final data = response.data;
        String? token;
        if (data is Map) {
          token = (data['accessToken'] ??
                  data['token'] ??
                  data['jwt'] ??
                  data['access_token'])
              ?.toString();
        }
        if (token != null && token.isNotEmpty) {
          await TokenStorage.saveToken(token); // permanent save
        }
        return {'success': true, 'data': data};
      }
      return {'success': false, 'message': _err(response.data, code)};
    } on DioException catch (e) {
      return {
        'success': false,
        'message': 'Network error: ${e.message ?? 'please try again'}',
      };
    }
  }

  // LOGOUT — token hatao
  Future<void> logout() async {
    await TokenStorage.clearToken();
  }

  // FORGOT PASSWORD
  Future<Map<String, dynamic>> forgotPassword({required String email}) async {
    try {
      final response =
          await _dio.post(ApiConfig.forgotPassword, data: {'email': email});
      final status = response.statusCode ?? 0;
      if (status >= 200 && status < 300) {
        return {'success': true, 'data': response.data};
      }
      return {'success': false, 'message': _err(response.data, status)};
    } on DioException catch (e) {
      return {
        'success': false,
        'message': 'Network error: ${e.message ?? 'please try again'}',
      };
    }
  }

  // VERIFY OTP
  Future<Map<String, dynamic>> verifyOtp({
    required String email,
    required String code,
  }) async {
    try {
      final response = await _dio
          .post(ApiConfig.verifyOtp, data: {'email': email, 'code': code});
      final status = response.statusCode ?? 0;
      if (status >= 200 && status < 300) {
        final ticket = (response.data is Map)
            ? response.data['resetTicket']?.toString()
            : null;
        if (ticket == null || ticket.isEmpty) {
          return {'success': false, 'message': 'Invalid response from server'};
        }
        return {'success': true, 'resetTicket': ticket};
      }
      return {'success': false, 'message': _err(response.data, status)};
    } on DioException catch (e) {
      return {
        'success': false,
        'message': 'Network error: ${e.message ?? 'please try again'}',
      };
    }
  }

  // RESET PASSWORD
  Future<Map<String, dynamic>> resetPassword({
    required String resetTicket,
    required String newPassword,
  }) async {
    try {
      final response = await _dio.post(ApiConfig.resetPassword,
          data: {'resetTicket': resetTicket, 'newPassword': newPassword});
      final status = response.statusCode ?? 0;
      if (status >= 200 && status < 300) {
        return {'success': true};
      }
      return {'success': false, 'message': _err(response.data, status)};
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
          (code == 401
              ? 'Wrong email or password'
              : 'Something went wrong (code $code)');
    }
    return code == 401
        ? 'Wrong email or password'
        : 'Something went wrong (code $code)';
  }
}
