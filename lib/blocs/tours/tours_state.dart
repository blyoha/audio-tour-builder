import 'package:equatable/equatable.dart';

import '../../repositories/models/tour.dart';

abstract class ToursState extends Equatable {
  const ToursState();

  @override
  List<Object?> get props => [];
}

class ToursInitial extends ToursState {
  const ToursInitial();
}

class ToursLoading extends ToursState {
  const ToursLoading();
}

class ToursError extends ToursState {
  final String error;

  const ToursError({required this.error});

  @override
  List<Object?> get props => [error];
}

class ToursTourLoaded extends ToursState {
  final Tour tour;

  const ToursTourLoaded({required this.tour});

  ToursTourLoaded copyWith({
    Tour? tour,
  }) {
    return ToursTourLoaded(
      tour: tour ?? this.tour,
    );
  }

  @override
  List<Object?> get props => [tour];
}

class ToursSaving extends ToursState {
  const ToursSaving();
}

class ToursTourSaved extends ToursState {
  final Tour tour;

  const ToursTourSaved({required this.tour});

  @override
  List<Object?> get props => [tour];
}

class ToursAllLoaded extends ToursState {
  final List<Tour> tours;

  const ToursAllLoaded({
    required this.tours,
  });

  @override
  List<Object?> get props => [tours];
}
