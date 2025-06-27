import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  const ApiService({required Dio dio}) : _dio = dio;
  Future<Response> post({
    required body,
    required String url,
    required String token,
    String? contentType,
    Map<String, dynamic>? headers,
  }) async {
    var response = await _dio.post(
      url,
      data: body,
      options: Options(
        contentType: contentType ?? 'application/x-www-form-urlencoded',
        headers: headers ?? {'Authorization': 'Bearer $token'},
      ),
    );
    return response;
  }
}
