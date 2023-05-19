part of 'routing_bloc.dart';

@immutable
abstract class RoutingEvent {}

class RoutingStart extends RoutingEvent {
  // Everything is set and user's ready to go
}

class RoutingFinish extends RoutingEvent {
  // User finished the Routing
}

class RoutingSetActivePlace extends RoutingEvent {
  // User approached the next place
  final Place place;

  RoutingSetActivePlace({required this.place});
}

class RoutingGoToNextPlace extends RoutingEvent {
  // When user is done with the place and ready to go to the next one
}
