import 'package:dartz/dartz.dart';

typedef RepoReponse<T> = Either<T, Failure>;

class Failure implements Exception {
  final String message;

  Failure(this.message);
}
