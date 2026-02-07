/// Base app error class
sealed class AppError implements Exception {
  final String message;
  final Object? originalError;
  final StackTrace? stackTrace;

  const AppError(this.message, [this.originalError, this.stackTrace]);

  @override
  String toString() =>
      '$runtimeType: $message ${originalError != null ? '($originalError)' : ''}';
}

class NetworkError extends AppError {
  const NetworkError(
      [super.message = 'Network connection failed',
      super.originalError,
      super.stackTrace]);
}

class DatabaseError extends AppError {
  const DatabaseError(
      [super.message = 'Database operation failed',
      super.originalError,
      super.stackTrace]);
}

class LocationError extends AppError {
  const LocationError(
      [super.message = 'Location service failed',
      super.originalError,
      super.stackTrace]);
}

class PermissionError extends AppError {
  const PermissionError(
      [super.message = 'Permission denied',
      super.originalError,
      super.stackTrace]);
}

class FileSystemError extends AppError {
  const FileSystemError(
      [super.message = 'File operation failed',
      super.originalError,
      super.stackTrace]);
}

class ValidationError extends AppError {
  const ValidationError(super.message, [super.originalError, super.stackTrace]);
}

class UnknownError extends AppError {
  const UnknownError(
      [super.message = 'An unexpected error occurred',
      super.originalError,
      super.stackTrace]);
}
