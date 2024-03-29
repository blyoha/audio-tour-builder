import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../../api_key.dart';
import '../../../../blocs/routing/routing_bloc.dart';
import '../../../../repositories/models/tour.dart';
import '../../../../theme/theme_constants.dart';
import 'place_marker.dart';

class RouteMap extends StatefulWidget {
  final Tour tour;

  const RouteMap({Key? key, required this.tour}) : super(key: key);

  @override
  State<RouteMap> createState() => _RouteMapState();
}

class _RouteMapState extends State<RouteMap> {
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  late final MapOptions mapOptions;
  late final MapController mapController;
  late List<LatLng> places;

  @override
  void initState() {
    super.initState();

    places = [];
    for (var place in widget.tour.places) {
      places.add(place.location!);
    }

    mapOptions = MapOptions(
      center: places.first,
      zoom: 18.0,
    );
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () async {
                final pos = await context.read<RoutingBloc>().currentPosition();
                if (pos != null) {
                  mapController.move(pos, 18.0);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.5),
                        blurRadius: 4.0,
                      )
                    ]),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(Icons.my_location_outlined, size: 28.0),
                ),
              ),
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: StreamBuilder<Position>(
          stream:
              Geolocator.getPositionStream(locationSettings: locationSettings),
          builder: (context, snapshot) {
            return Stack(
              children: [
                FlutterMap(
                  options: mapOptions,
                  mapController: mapController,
                  children: [
                    _buildTile(),
                    _buildPath(widget.tour.places),
                    _buildMarkers(widget.tour.places),
                    _buildUser(snapshot.data),
                  ],
                ),
              ],
            );
          }),
    );
  }

  Widget _buildPath(List places) {
    final Polyline polyline = Polyline(
      points: [],
      color: primaryTextColor,
      strokeWidth: 6.0,
    );
    for (var p in places) {
      polyline.points.add(p.location);
    }

    return PolylineLayer(polylines: [polyline]);
  }

  Widget _buildMarkers(List places) {
    final List<Marker> markers = [];
    for (var p in places) {
      markers.add(Marker(
        point: p.location,
        builder: (context) => PlaceMarker(place: p),
      ));
    }

    return MarkerLayer(markers: markers);
  }

  Widget _buildUser(Position? position) {
    LatLng pos = LatLng(0, 0);
    if (position != null) {
      pos = LatLng(position.latitude, position.longitude);
    }

    return MarkerLayer(
      markers: [
        Marker(
          point: pos,
          height: 36.0,
          width: 36.0,
          builder: (context) => const Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.circle_rounded,
                size: 36.0,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black54,
                    blurRadius: 4,
                    offset: Offset(0, 1),
                  )
                ],
              ),
              Icon(
                Icons.circle_rounded,
                size: 28.0,
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildTile() {
    return TileLayer(
      urlTemplate: "$urlTemplate?api_key={api_key}",
      additionalOptions: const {"api_key": mapsApiKey},
    );
  }
}
