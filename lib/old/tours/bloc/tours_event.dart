import 'package:equatable/equatable.dart';

abstract class ToursEvent extends Equatable {
  const ToursEvent();

  @override
  List<Object?> get props => [];
}

class ToursLoad extends ToursEvent {}