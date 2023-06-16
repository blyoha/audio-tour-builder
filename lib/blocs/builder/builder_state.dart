part of 'builder_bloc.dart';

@immutable
abstract class BuilderState {}

class BuilderLoading extends BuilderState {}

class BuilderEditing extends BuilderState {
  final Tour tour;

  BuilderEditing({required this.tour});
}

class BuilderError extends BuilderState {
  final String message;

  BuilderError({required this.message});
}
