import 'package:flutter/foundation.dart';

// Global error handler
class ErrorHandler {
  static void logError(Object error, StackTrace? stackTrace) {
    debugPrint('Error: $error');
    if (stackTrace != null) debugPrint('Stack: $stackTrace');
  }
}
