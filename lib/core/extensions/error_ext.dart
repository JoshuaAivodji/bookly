import 'package:dartz/dartz.dart';

import '../errors/request_failures.dart';

extension EitherExtension<T> on Either<Failure, T> {
  void handle({
    required Function(T) onSuccess,
    Function(Failure)? onFailure
  }) {
    fold(
            (Failure failure) => onFailure?.call(failure),
            (success) => onSuccess(success)
    );
  }
}
