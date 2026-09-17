import 'package:dio/dio.dart';
import 'api_config.dart';
import '../models/property.dart';

class PropertyService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {'Content-Type': 'application/json'},
      validateStatus: (status) => true,
    ),
  );

  // FEATURED properties
  Future<Map<String, dynamic>> getFeatured({int page = 0, int size = 20}) {
    return _fetchList(ApiConfig.featured, page: page, size: size);
  }

  // RECOMMENDED properties
  Future<Map<String, dynamic>> getRecommended({int page = 0, int size = 20}) {
    return _fetchList(ApiConfig.recommended, page: page, size: size);
  }

  // ALL properties
  Future<Map<String, dynamic>> getAll({int page = 0, int size = 20}) {
    return _fetchList(ApiConfig.properties, page: page, size: size);
  }

  // Common fetch — dono endpoints isi ko use karte hain
  Future<Map<String, dynamic>> _fetchList(String path,
      {int page = 0, int size = 20}) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: {'page': page, 'size': size},
      );
      final code = response.statusCode ?? 0;
      if (code >= 200 && code < 300) {
        final data = response.data;
        final items = (data is Map && data['items'] is List)
            ? data['items'] as List
            : <dynamic>[];
        final list = items
            .map((e) => Property.fromJson(e as Map<String, dynamic>))
            .toList();
        return {'success': true, 'data': list};
      }
      return {'success': false, 'message': 'Server error (code $code)'};
    } on DioException catch (e) {
      return {
        'success': false,
        'message': 'Network error: ${e.message ?? 'please try again'}',
      };
    }
  }
}
