import 'package:equatable/equatable.dart';

import '../../repositories/models/tour.dart';

abstract class ToursEvent extends Equatable {
  const ToursEvent();

  @override
  List<Object?> get props => [];
}

// TODO: Change to ToursUpdateTour
class ToursAddPlace extends ToursEvent {
  final String title;
  final String description;

  const ToursAddPlace({
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [title, description];
}

class ToursLoadTour extends ToursEvent {
  final Tour? tour;

  const ToursLoadTour({this.tour});

  @override
  List<Object?> get props => [tour];
}

class ToursSaveTour extends ToursEvent {
  final Tour tour;

  const ToursSaveTour({required this.tour});

  @override
  List<Object?> get props => [tour];
}

class ToursLoadAll extends ToursEvent {}

class ToursDeleteTour extends ToursEvent {
  final Tour tour;

  const ToursDeleteTour({required this.tour});

  @override
  List<Object?> get props => [tour];
}
