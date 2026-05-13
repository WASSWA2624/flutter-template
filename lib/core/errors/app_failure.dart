enum AppFailureCategory {
  network,
  timeout,
  offline,
  cancelled,
  unauthorized,
  forbidden,
  notFound,
  validation,
  unexpectedResponse,
  storage,
  unexpected,
}

final class AppFailure {
  const AppFailure._({
    required this.category,
    required this.code,
    required this.messageKey,
    required this.isRetryable,
    this.statusCode,
    this.validationFields = const <String>{},
  });

  factory AppFailure.network({
    String code = 'network.request_failed',
    int? statusCode,
    bool isRetryable = true,
  }) {
    return AppFailure._(
      category: AppFailureCategory.network,
      code: code,
      messageKey: 'errors.network',
      isRetryable: isRetryable,
      statusCode: statusCode,
    );
  }

  factory AppFailure.timeout({int? statusCode}) {
    return AppFailure._(
      category: AppFailureCategory.timeout,
      code: 'network.timeout',
      messageKey: 'errors.timeout',
      isRetryable: true,
      statusCode: statusCode,
    );
  }

  factory AppFailure.offline({int? statusCode}) {
    return AppFailure._(
      category: AppFailureCategory.offline,
      code: 'network.offline',
      messageKey: 'errors.offline',
      isRetryable: true,
      statusCode: statusCode,
    );
  }

  factory AppFailure.cancelled() {
    return const AppFailure._(
      category: AppFailureCategory.cancelled,
      code: 'network.cancelled',
      messageKey: 'errors.cancelled',
      isRetryable: false,
    );
  }

  factory AppFailure.unauthorized({int? statusCode}) {
    return AppFailure._(
      category: AppFailureCategory.unauthorized,
      code: 'auth.unauthorized',
      messageKey: 'errors.unauthorized',
      isRetryable: false,
      statusCode: statusCode,
    );
  }

  factory AppFailure.forbidden({int? statusCode}) {
    return AppFailure._(
      category: AppFailureCategory.forbidden,
      code: 'auth.forbidden',
      messageKey: 'errors.forbidden',
      isRetryable: false,
      statusCode: statusCode,
    );
  }

  factory AppFailure.notFound({int? statusCode}) {
    return AppFailure._(
      category: AppFailureCategory.notFound,
      code: 'network.not_found',
      messageKey: 'errors.notFound',
      isRetryable: false,
      statusCode: statusCode,
    );
  }

  factory AppFailure.validation({
    String code = 'validation.failed',
    int? statusCode,
    Set<String> validationFields = const <String>{},
  }) {
    return AppFailure._(
      category: AppFailureCategory.validation,
      code: code,
      messageKey: 'errors.validation',
      isRetryable: false,
      statusCode: statusCode,
      validationFields: _normalizedFields(validationFields),
    );
  }

  factory AppFailure.unexpectedResponse({int? statusCode}) {
    return AppFailure._(
      category: AppFailureCategory.unexpectedResponse,
      code: 'network.unexpected_response',
      messageKey: 'errors.unexpectedResponse',
      isRetryable: false,
      statusCode: statusCode,
    );
  }

  factory AppFailure.storage({
    String code = 'storage.failed',
    bool isRetryable = false,
  }) {
    return AppFailure._(
      category: AppFailureCategory.storage,
      code: code,
      messageKey: 'errors.storage',
      isRetryable: isRetryable,
    );
  }

  factory AppFailure.unexpected() {
    return const AppFailure._(
      category: AppFailureCategory.unexpected,
      code: 'unexpected.failed',
      messageKey: 'errors.unexpected',
      isRetryable: false,
    );
  }

  final AppFailureCategory category;
  final String code;
  final String messageKey;
  final bool isRetryable;
  final int? statusCode;
  final Set<String> validationFields;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AppFailure &&
            other.category == category &&
            other.code == code &&
            other.messageKey == messageKey &&
            other.isRetryable == isRetryable &&
            other.statusCode == statusCode &&
            _setEquals(other.validationFields, validationFields);
  }

  @override
  int get hashCode {
    return Object.hash(
      category,
      code,
      messageKey,
      isRetryable,
      statusCode,
      Object.hashAllUnordered(validationFields),
    );
  }

  static Set<String> _normalizedFields(Set<String> fields) {
    final normalizedFields = fields
        .map((field) => field.trim())
        .where((field) => field.isNotEmpty)
        .toSet();

    return Set<String>.unmodifiable(normalizedFields);
  }

  static bool _setEquals(Set<String> left, Set<String> right) {
    if (left.length != right.length) {
      return false;
    }

    for (final value in left) {
      if (!right.contains(value)) {
        return false;
      }
    }

    return true;
  }
}
