import 'package:flutter/foundation.dart';
import 'app_error.dart';

// Global error handler
class ErrorHandler {
  static void logError(Object error, StackTrace? stackTrace) {
    debugPrint('Error: $error');
    if (stackTrace != null) debugPrint('Stack: $stackTrace');
  }

  static AppError handle(Object error, [StackTrace? stackTrace]) {
    logError(error, stackTrace);
    if (error is AppError) return error;
    return UnknownError('Unexpected error: $error', error, stackTrace);
  }
}
