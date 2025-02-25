import 'package:dartz/dartz.dart';

typedef RepoReponse<T> = Either<_Failure, T>;

class _Failure implements Exception {
  final String message;

  _Failure(this.message);
}

class FailureResponse<T> extends Left<_Failure, T> {
  FailureResponse(String message) : super(_Failure(message));
}

class SuccessResponse<T> extends Right<_Failure, T> {
  SuccessResponse(super.data);
}
