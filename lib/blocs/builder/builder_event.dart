part of 'builder_bloc.dart';

@immutable
abstract class BuilderEvent {}

class BuilderSave extends BuilderEvent {
  // When user presses "Save" button
  final Tour tour;

  BuilderSave({required this.tour});
}

class BuilderLoad extends BuilderEvent {
  // When user edits an existing tour
  final Tour tour;

  BuilderLoad({required this.tour});
}
