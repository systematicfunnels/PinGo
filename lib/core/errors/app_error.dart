/// Base app error class
sealed class AppError implements Exception {
  final String message;
  final Object? originalError;
  final StackTrace? stackTrace;

  const AppError(this.message, [this.originalError, this.stackTrace]);

  @override
  String toString() => 'AppError: $message ${originalError != null ? '($originalError)' : ''}';
}

class NetworkError extends AppError {
  const NetworkError(super.message, [super.originalError, super.stackTrace]);
}

class DatabaseError extends AppError {
  const DatabaseError(super.message, [super.originalError, super.stackTrace]);
}

class UnknownError extends AppError {
  const UnknownError(super.message, [super.originalError, super.stackTrace]);
}

