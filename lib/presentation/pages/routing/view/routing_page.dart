import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../blocs/routing/routing_bloc.dart';
import '../../../../repositories/location_repository.dart';
import '../../../../repositories/models/tour.dart';
import '../widgets/route_map.dart';
import '../widgets/route_sheet.dart';

class RoutingPage extends StatefulWidget {
  static const String route = 'routing';

  final Tour tour;

  const RoutingPage({Key? key, required this.tour}) : super(key: key);

  @override
  State<RoutingPage> createState() => _RoutingPageState();
}

class _RoutingPageState extends State<RoutingPage> {
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );
  late final RoutingBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = RoutingBloc(
      places: widget.tour.places,
      locationRepository: LocationRepository(),
    );
    bloc.add(RoutingStart());

    askPermission();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        backgroundColor: Colors.white60,
        floatingActionButton: FloatingActionButton(
          child: const Text("Next"),
          onPressed: () {
            bloc.add(RoutingGoToNextPlace());
          },
        ),
        body: BlocConsumer<RoutingBloc, RoutingState>(
          listener: (context, state) {
            if (state is RoutingFinished) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Tour finished"),
                duration: Duration(seconds: 1),
              ));
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state is RoutingLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Stack(
              children: [
                RouteMap(tour: widget.tour),
                RouteSheet(places: widget.tour.places),
              ],
            );
          },
        ),
      ),
    );
  }

  // TODO: Use permissions from BLoC
  void askPermission() async {
    // LocationPermission permission = await Geolocator.checkPermission();
    LocationPermission permission = await Geolocator.requestPermission();
  }
}
