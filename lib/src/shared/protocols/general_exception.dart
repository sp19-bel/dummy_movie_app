class GeneralException implements Exception {
  final int? statusCode;
  final String? message;

  GeneralException({this.statusCode, this.message});

  @override
  String toString() => message ?? 'An unexpected error occurred';
}

class NoInternetException extends GeneralException {
  NoInternetException()
      : super(
          message: 'No internet connection. Please check your network.',
        );
}
