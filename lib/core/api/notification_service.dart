import 'package:dio/dio.dart';
import 'dio_client.dart';

class NotificationService {
  final Dio _dio = DioClient.dio;

  Future<Map<String, dynamic>> getNotifications() async {
    try {
      final res = await _dio
          .get('/api/notifications', queryParameters: {'page': 0, 'size': 50});
      final code = res.statusCode ?? 0;
      if (code >= 200 && code < 300) {
        final data = res.data;
        // items[] ya seedha list — dono handle
        final raw = (data is Map && data['items'] is List)
            ? data['items'] as List
            : (data is List ? data : <dynamic>[]);
        final list = raw.map((e) {
          final m = e as Map<String, dynamic>;
          return {
            'title': (m['title'] ?? m['heading'] ?? 'Notification').toString(),
            'desc': (m['body'] ?? m['message'] ?? m['description'] ?? '')
                .toString(),
            'time': (m['createdAt'] ?? m['time'] ?? '').toString(),
          };
        }).toList();
        return {'success': true, 'data': list};
      }
      return {'success': false, 'message': 'Error ($code)'};
    } on DioException catch (e) {
      return {'success': false, 'message': e.message ?? 'Network error'};
    }
  }
}
