import 'package:dartz/dartz.dart';

typedef RepoReponse<T> = Either<Failure, T>;

class Failure implements Exception {
  final String message;

  Failure(this.message);
}
