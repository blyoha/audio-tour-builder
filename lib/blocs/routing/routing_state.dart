part of 'routing_bloc.dart';

@immutable
abstract class RoutingState {}

class RoutingInitial extends RoutingState {
  // When user hasn't started the route yet
}

class RoutingLoading extends RoutingState {
  // When some data is still loading (before the Routing starts)
}

class RoutingOnTheWay extends RoutingState {
  // When user in on the way to the nex place
  final Place place;

  RoutingOnTheWay({required this.place});
}

class RoutingInPlace extends RoutingState {
  // When user is near the place and able to listen to audio
  final Place place;

  RoutingInPlace({required this.place});
}

class RoutingFinished extends RoutingState {}
