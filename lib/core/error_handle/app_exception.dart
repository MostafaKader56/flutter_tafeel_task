import 'error_type.dart';

class AppException implements Exception {
  final ErrorType errorType;
  final String? originalMessage;
  final dynamic originalError;

  AppException(this.errorType, {this.originalMessage, this.originalError});

  @override
  String toString() => 'AppException: $errorType - $originalMessage';
}
