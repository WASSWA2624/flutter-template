import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/core/config/app_config_provider.dart';
import 'package:flutter_template/core/network/api_client.dart';

final dioProvider = Provider<Dio>((ref) {
  final config = ref.watch(appConfigProvider);
  final dio = Dio(
    BaseOptions(
      baseUrl: config.apiBaseUrl.toString(),
      connectTimeout: config.apiTimeout,
      receiveTimeout: config.apiTimeout,
      sendTimeout: config.apiTimeout,
    ),
  );

  ref.onDispose(() {
    dio.close(force: true);
  });

  return dio;
});

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(dio: ref.watch(dioProvider));
});
