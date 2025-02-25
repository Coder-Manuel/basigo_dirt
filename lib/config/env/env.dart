import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  // ======== API KEYS ============
  @EnviedField(varName: 'GOOGLE_API_KEY', obfuscate: true)
  static final String googleApiKey = _Env.googleApiKey;
}
