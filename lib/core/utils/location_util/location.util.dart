import 'package:basigo_dirt/core/utils/error_util/error_wrapper.dart';
import 'package:basigo_dirt/core/widgets/offline_widget/connectivity_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

/// Utility that hosts the Location methods
class LocationUtil {
  static const String _library = 'LocationUtil';

  /// Get the Current Geo Location of the User.
  ///
  /// It might return [null] if the [LocationPermission] is not enabled.
  ///
  /// The [LocationAccuracy] is set to Best
  static Future<(Position, String?)?> getCurrentPosition() async {
    Position? currentLocation;

    return await ErrorWrapper.async<(Position, String?)?>(
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

        if (currentLocation != null) {
          final connectivityCTRL = Get.find<ConnectivityController>();

          if (connectivityCTRL.isConnected) {
            final placemark = await placemarkFromCoordinates(
              currentLocation!.latitude,
              currentLocation!.longitude,
            );

            return (currentLocation!, placemark.reversed.firstOrNull?.name);
          }

          return (currentLocation!, 'NA');
        }

        return null;
      },
      library: _library,
      description: 'while fetching the location from the device',
    );
  }
}
