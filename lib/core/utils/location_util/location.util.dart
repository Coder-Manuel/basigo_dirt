import 'package:basigo_dirt/core/utils/error_util/error_wrapper.dart';
import 'package:geolocator/geolocator.dart';

/// Utility that hosts the Location methods
class LocationUtil {
  static const String _library = 'LocationUtil';

  /// Get the Current Geo Location of the User.
  ///
  /// It might return [null] if the [LocationPermission] is not enabled.
  ///
  /// The [LocationAccuracy] is set to Best
  static Future<Position?> getCurrentPosition() async {
    Position? currentLocation;

    await ErrorWrapper.wrap(
      () async {
        LocationPermission permission = await Geolocator.checkPermission();

        if (permission != LocationPermission.always ||
            permission != LocationPermission.whileInUse) {
          permission = await Geolocator.requestPermission();
        }

        if (permission == LocationPermission.always ||
            permission == LocationPermission.whileInUse) {
          currentLocation = await Geolocator.getCurrentPosition(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.best,
            ),
          );
        }
      },
      library: _library,
      description: 'while fetching the location from the device',
    );

    return currentLocation;
  }
}
