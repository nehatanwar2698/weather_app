/// custom exception with message
class CustomException implements Exception {
  /// constructor
  CustomException({required this.message});

  /// contain exception message
  final String message;
}
