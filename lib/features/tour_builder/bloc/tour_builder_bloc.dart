import 'package:flutter_bloc/flutter_bloc.dart';

import '../../tours/tour.dart';
import 'tour_builder_event.dart';
import 'tour_builder_state.dart';

class TourBuilderBloc extends Bloc<TourBuilderEvent, TourBuilderState> {
  final List<Place> places = [];

  TourBuilderBloc() : super(const TourBuilderInitial()) {
    on<TourBuilderAddPlace>(_onAddPlace);
    on<TourBuilderLoad>(_onLoad);
    on<TourBuilderSave>(_onSave);
  }

  void _onSave(
      TourBuilderSave event,
      Emitter<TourBuilderState> emit,
      ) {
    emit(const TourBuilderSaving());

    // emit(TourBuilderSaved(tour: event.tour));
  }

  void _onLoad(
      TourBuilderLoad event,
      Emitter<TourBuilderState> emit,
      ) {
    emit(
      TourBuilderLoaded(
          tour: event.tour ??
              Tour(
                title: '',
                description: '',
                places: [],
                distance: 0.0,
                time: 0.0,
              )),
    );
  }

  void _onAddPlace(
      TourBuilderAddPlace event,
      Emitter<TourBuilderState> emit,
      ) {
    final Place newPlace = Place(
      title: event.title,
      description: event.description,
    );

    Tour tour = (state as TourBuilderLoaded).tour.copyWith();
    tour.places.add(newPlace);
    emit(TourBuilderLoaded(tour: tour));
  }
}
