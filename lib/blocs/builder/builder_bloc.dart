import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';

import '../../repositories/location_repository.dart';
import '../../repositories/models/tour.dart';
import '../../repositories/tours_repository.dart';

part 'builder_event.dart';

part 'builder_state.dart';

class BuilderBloc extends Bloc<BuilderEvent, BuilderState> {
  final ToursRepository toursRepo;
  final LocationRepository locationRepo;
  // Tour tour = Tour.empty();

  BuilderBloc({
    required this.toursRepo,
    required this.locationRepo,
  }) : super(BuilderLoading()) {
    on<BuilderSave>(_onSave);
    on<BuilderLoad>(_onLoad);
  }

  void _onLoad(BuilderLoad event, Emitter<BuilderState> emit) {
    emit(BuilderEditing(tour: event.tour));
  }

  Future<void> _onSave(BuilderSave event, Emitter<BuilderState> emit) async {
    emit(BuilderLoading());
    try {
      final savedTour = await toursRepo.updateTour(event.tour);
      emit(BuilderEditing(tour: savedTour));
    } catch (error) {
      emit(BuilderError(message: "Couldn't save the tour"));
    }
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
