import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../repositories/models/tour.dart';

abstract class ToursEvent extends Equatable {
  const ToursEvent();

  @override
  List<Object?> get props => [];
}

// TODO: Change to ToursUpdateTour
class ToursAddPlace extends ToursEvent {
  final Key key;
  final String title;
  final String description;
  final LatLng location;

  const ToursAddPlace({
    required this.key,
    required this.title,
    required this.description,
    required this.location,
  });

  @override
  List<Object?> get props => [key, title, description];
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
