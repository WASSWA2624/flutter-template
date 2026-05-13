import 'package:dio/dio.dart';

final class ApiClient {
  const ApiClient({required Dio dio}) : _dio = dio;

  final Dio _dio;

  Dio get dio => _dio;

  Uri get baseUri => Uri.parse(_dio.options.baseUrl);
}
