import 'package:geolocator/geolocator.dart';

class LocationRepository {
  final Stream<Position> currentLocation = Geolocator.getPositionStream();

  bool nearThePlace(final Position position) {
    return true;
  }

  Future<Position?> currentPosition() async {
    return await Geolocator.getLastKnownPosition();
  }
}
