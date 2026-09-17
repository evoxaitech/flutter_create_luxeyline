import 'package:dio/dio.dart';
import 'dio_client.dart';
import '../models/property.dart';

class FavouritesService {
  final Dio _dio = DioClient.dio;

  // Saved properties list
  Future<Map<String, dynamic>> getFavourites() async {
    try {
      final res = await _dio.get('/api/users/me/favorites',
          queryParameters: {'page': 0, 'size': 50});
      final code = res.statusCode ?? 0;
      if (code >= 200 && code < 300) {
        final data = res.data;
        final items = (data is Map && data['items'] is List)
            ? data['items'] as List
            : <dynamic>[];
        final list = items
            .map((e) => Property.fromJson(e as Map<String, dynamic>))
            .toList();
        return {'success': true, 'data': list};
      }
      return {'success': false, 'message': 'Error ($code)'};
    } on DioException catch (e) {
      return {'success': false, 'message': e.message ?? 'Network error'};
    }
  }

  // Add to favourites
  Future<bool> addFavourite(String id) async {
    try {
      final res = await _dio.put('/api/properties/$id/favorite');
      return (res.statusCode ?? 0) >= 200 && (res.statusCode ?? 0) < 300;
    } catch (_) {
      return false;
    }
  }

  // Remove from favourites
  Future<bool> removeFavourite(String id) async {
    try {
      final res = await _dio.delete('/api/properties/$id/favorite');
      return (res.statusCode ?? 0) >= 200 && (res.statusCode ?? 0) < 300;
    } catch (_) {
      return false;
    }
  }
}
