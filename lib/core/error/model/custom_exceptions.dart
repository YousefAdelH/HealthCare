class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}

class DatabaseException implements Exception {
  final String message;
  DatabaseException(this.message);
}

class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);
}
