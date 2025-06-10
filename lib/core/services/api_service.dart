import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  const ApiService({required Dio dio}) : _dio = dio;
  Future<Response> post({
    required body,
    required String url,
    required String token,
    String? contentType,
  }) async {
    return await _dio.post(
      url,
      data: body,

      options: Options(
        contentType: contentType,
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
  }
}
