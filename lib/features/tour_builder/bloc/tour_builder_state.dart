import 'package:equatable/equatable.dart';

import '../../tours/tour.dart';

abstract class TourBuilderState extends Equatable {
  const TourBuilderState();

  @override
  List<Object?> get props => [];
}

class TourBuilderInitial extends TourBuilderState {
  const TourBuilderInitial();
}

class TourBuilderError extends TourBuilderState {
  final String error;

  const TourBuilderError({required this.error});

  @override
  List<Object?> get props => [error];
}

class TourBuilderLoaded extends TourBuilderState {
  final Tour tour;

  const TourBuilderLoaded({required this.tour});

  TourBuilderLoaded copyWith({
    Tour? tour,
  }) {
    return TourBuilderLoaded(
      tour: tour ?? this.tour,
    );
  }

  @override
  List<Object?> get props => [tour];
}

class TourBuilderSaving extends TourBuilderState {
  const TourBuilderSaving();
}

class TourBuilderSaved extends TourBuilderState {
  final Tour tour;

  const TourBuilderSaved({required this.tour});

  @override
  List<Object?> get props => [tour];
}
