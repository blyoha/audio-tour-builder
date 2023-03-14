import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/models/models.dart';
import '../../repositories/tours_repository.dart';
import 'tours_event.dart';
import 'tours_state.dart';

class ToursBloc extends Bloc<ToursEvent, ToursState> {
  final FirebaseTourRepository toursRepository;

  ToursBloc({required this.toursRepository}) : super(const ToursInitial()) {
    on<ToursLoadAll>(_onLoadAll);
    on<ToursAddPlace>(_onAddPlace);
    on<ToursLoadTour>(_onLoadTour);
    on<ToursSaveTour>(_onSaveTour);
    on<ToursDeleteTour>(_onDeleteTour);
  }

  void _onSaveTour(
    ToursSaveTour event,
    Emitter<ToursState> emit,
  ) async {
    emit(const ToursSaving());

    Tour updatedTour = Tour.empty();
    try {
      updatedTour = await toursRepository.updateTour(event.tour);
    } catch (error) {
      emit(const ToursError(error: "Couldn't save the tour"));
    }
    emit(ToursTourLoaded(tour: updatedTour));
  }

  void _onDeleteTour(
    ToursDeleteTour event,
    Emitter<ToursState> emit,
  ) {
    toursRepository.deleteTour(event.tour);
  }

  void _onLoadTour(
    ToursLoadTour event,
    Emitter<ToursState> emit,
  ) {
    emit(
      ToursTourLoaded(tour: event.tour ?? Tour.empty()),
    );
  }

  void _onAddPlace(
    ToursAddPlace event,
    Emitter<ToursState> emit,
  ) {
    final Place newPlace = Place(
      title: event.title,
      description: event.description,
      location: event.location,
    );

    Tour tour = (state as ToursTourLoaded).tour.copyWith();
    tour.places.add(newPlace);
    emit(ToursTourLoaded(tour: tour));
  }

  void _onLoadAll(
    ToursLoadAll event,
    Emitter<ToursState> emit,
  ) async {
    emit(const ToursLoading());

    try {
      final List<Tour> allTours = await toursRepository.getAllTours();
      emit(ToursAllLoaded(tours: allTours));
    } catch (e) {
      emit(ToursError(error: e.toString()));
    }
  }
}
