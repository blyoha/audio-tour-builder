import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../../blocs/routing/routing_bloc.dart';
import '../../../../repositories/models/models.dart';

const mapsApiKey = '578c2399-45e0-47fe-8176-d6fcdaeb07e9';
const urlTemplate =
    'https://tiles.stadiamaps.com/tiles/osm_bright/{z}/{x}/{y}{r}.png';

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
    return StreamBuilder<Position>(
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
              Positioned(
                right: 10.0,
                top: MediaQuery.paddingOf(context).top,
                child: FloatingActionButton.small(
                  child: const Icon(Icons.my_location_outlined),
                  onPressed: () async {
                    final pos =
                        await context.read<RoutingBloc>().currentPosition();
                    if (pos != null) {
                      mapController.move(pos, 18.0);
                    }
                  },
                ),
              ),
            ],
          );
        });
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
