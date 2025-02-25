import 'package:basigo_dirt/config/config.dart';
import 'package:observe_internet_connectivity/observe_internet_connectivity.dart';

/// Observicng strategy for testing environments.
///
/// > _`@returns: [InternetObservingStrategy]`_
class _TestObservingStrategy extends InternetObservingStrategy {
  @override
  Future<bool> get hasInternetConnection async => true;

  @override
  Duration? get initialDuration => const Duration(seconds: 0);

  @override
  Duration get interval => const Duration(seconds: 5);
}

class ConnectivityObservingStrategy {
  static InternetObservingStrategy get strategy {
    if (kTestingMode) {
      return _TestObservingStrategy();
    }

    return DefaultObServingStrategy();
  }
}
