import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';

import '../../repositories/location_repository.dart';
import '../../repositories/models/place.dart';

part 'routing_event.dart';

part 'routing_state.dart';

class RoutingBloc extends Bloc<RoutingEvent, RoutingState> {
  final LocationRepository locationRepo;
  final List<Place> places;
  late Iterator<Place> _iterator;

  RoutingBloc({
    required this.places,
    required this.locationRepo,
  }) : super(RoutingLoading()) {
    _iterator = places.iterator;
    if (!_checkPermission()) {
      _requestPermission();
    }

    on<RoutingStart>(_onStart);
    on<RoutingFinish>(_onFinish);
    on<RoutingSetActivePlace>(_onSetActivePlace);
    on<RoutingGoToNextPlace>(_onGoToNextPlace);
  }

  void _onStart(RoutingStart event, Emitter<RoutingState> emit) {
    emit(RoutingLoading());

    _iterator.moveNext(); // Set first place as active;
    // _checkPermission();
    // _requestPermission();

    locationRepo.currentLocation.listen((position) {
      final target = _iterator.current.location!;

      final distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        target.latitude,
        target.longitude,
      );

      if (distance <= 10.0) {
        add(RoutingSetActivePlace(place: _iterator.current));
      }
    });

    emit(RoutingOnTheWay(place: _iterator.current));
  }

  void _onFinish(RoutingFinish event, Emitter<RoutingState> emit) {
    // Stop traveling and leave the tour screen
    emit(RoutingFinished());
  }

  void _onGoToNextPlace(
      RoutingGoToNextPlace event, Emitter<RoutingState> emit) {
    // Move to next place or end the tour
    if (_iterator.moveNext()) {
      emit(RoutingOnTheWay(place: _iterator.current));
    } else {
      add(RoutingFinish());
    }
  }

  void _onSetActivePlace(
      RoutingSetActivePlace event, Emitter<RoutingState> emit) {
    emit(RoutingInPlace(place: event.place));
  }

  int currentPlace() {
    return _iterator.current.id as int;
  }

  bool _checkPermission() {
    // Check user location permission
    return false;
  }

  void _requestPermission() {
    // Request user location permission
  }

  Future<LatLng?> currentPosition() async {
    final loc = await locationRepo.currentPosition();
    if (loc != null) {
      return LatLng(loc.latitude, loc.longitude);
    } else {
      return null;
    }
  }
}
