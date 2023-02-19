import 'package:equatable/equatable.dart';

import '../../tours/tour.dart';

abstract class TourBuilderEvent extends Equatable {
  const TourBuilderEvent();

  @override
  List<Object?> get props => [];
}

class TourBuilderAddPlace extends TourBuilderEvent {
  final String title;
  final String description;

  const TourBuilderAddPlace({
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [title, description];
}

class TourBuilderLoad extends TourBuilderEvent {
  final Tour? tour;

  const TourBuilderLoad({this.tour});

  @override
  List<Object?> get props => [tour];
}

class TourBuilderSave extends TourBuilderEvent {
  final Tour tour;

  const TourBuilderSave({required this.tour});

  @override
  List<Object?> get props => [tour];
}