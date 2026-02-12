import 'package:dartz/dartz.dart';

import 'package:test_app/src/shared/protocols/general_exception.dart';

mixin ExceptionMixin {
  Future<Either<GeneralException, T>> handleResponse<T>(
    Future<T> Function() action,
  ) async {
    try {
      return right(await action());
    } on NoInternetException catch (_) {
      rethrow;
    } catch (e) {
      return left(GeneralException(message: e.toString()));
    }
  }
}
