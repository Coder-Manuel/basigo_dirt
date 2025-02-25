import 'dart:async';

import 'package:basigo_dirt/core/types/repo_reponse.type.dart';

abstract class UseCase<Type, Params> {
  FutureOr<RepoReponse<Type>> call(Params params);
}
