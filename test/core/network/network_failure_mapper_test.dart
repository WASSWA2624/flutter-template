import 'package:dio/dio.dart';
import 'package:flutter_template/core/errors/app_failure.dart';
import 'package:flutter_template/core/network/network_failure_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NetworkFailureMapper', () {
    const mapper = NetworkFailureMapper();

    test('maps Dio timeouts to retryable timeout failures', () {
      final failure = mapper.map(
        DioException(
          requestOptions: RequestOptions(path: '/readiness'),
          type: DioExceptionType.connectionTimeout,
        ),
        StackTrace.empty,
      );

      expect(failure.category, AppFailureCategory.timeout);
      expect(failure.isRetryable, isTrue);
    });

    test('maps unauthorized responses to auth failures', () {
      final requestOptions = RequestOptions(path: '/private');
      final failure = mapper.map(
        DioException(
          requestOptions: requestOptions,
          response: Response<Object?>(
            requestOptions: requestOptions,
            statusCode: 401,
          ),
          type: DioExceptionType.badResponse,
        ),
        StackTrace.empty,
      );

      expect(failure.category, AppFailureCategory.unauthorized);
      expect(failure.statusCode, 401);
      expect(failure.isRetryable, isFalse);
    });

    test('maps validation responses without exposing server messages', () {
      final requestOptions = RequestOptions(path: '/example-resources');
      final failure = mapper.map(
        DioException(
          requestOptions: requestOptions,
          response: Response<Object?>(
            requestOptions: requestOptions,
            statusCode: 422,
            data: <String, Object?>{
              'errors': <String, Object?>{
                'email': <String>['Sensitive server message'],
              },
            },
          ),
          type: DioExceptionType.badResponse,
        ),
        StackTrace.empty,
      );

      expect(failure.category, AppFailureCategory.validation);
      expect(failure.validationFields, <String>{'email'});
      expect(failure.messageKey, 'errors.validation');
    });

    test('maps invalid decoded payloads to unexpected response failures', () {
      final failure = mapper.map(
        const FormatException('Invalid payload.'),
        StackTrace.empty,
      );

      expect(failure.category, AppFailureCategory.unexpectedResponse);
    });
  });
}
