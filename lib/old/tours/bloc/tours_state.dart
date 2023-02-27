import 'package:equatable/equatable.dart';

import '../../../repositories/models/models.dart';


abstract class ToursState extends Equatable {
  const ToursState();

  @override
  List<Object?> get props => [];
}

class ToursLoading extends ToursState {
  const ToursLoading();
}

class ToursLoaded extends ToursState {
  final List<Tour> tours;

  const ToursLoaded({
    required this.tours,
  });

  @override
  List<Object?> get props => [tours];
}

class ToursError extends ToursState {
  final String error;

  const ToursError({
    required this.error,
  });

  @override
  List<Object?> get props => [error];
}
