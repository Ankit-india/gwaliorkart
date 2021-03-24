class UnAuthorizeException implements Exception {
  factory UnAuthorizeException(String message) {
    return UnAuthorizeException._internal(message);
  }
  UnAuthorizeException._internal(this.message);

  final String message;

  @override
  String toString() => 'UnAuthorizeException: $message';
}

class FormatException implements Exception {
  factory FormatException(String message) {
    return FormatException._internal(message);
  }
  FormatException._internal(this.message);

  final String message;

  @override
  String toString() => 'FormatException: $message';
}

class BadGatewayException implements Exception {
  factory BadGatewayException(String message) {
    return BadGatewayException._internal(message);
  }
  BadGatewayException._internal(this.message);

  final String message;

  @override
  String toString() => 'BadGatewayException: $message';
}
