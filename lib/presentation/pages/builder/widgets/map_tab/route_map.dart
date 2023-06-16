import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../api_key.dart';
import '../../../../../blocs/builder/builder_bloc.dart';
import '../../../../../repositories/models/models.dart';
import '../../../../../theme/theme_constants.dart';
import 'place_edit_sheet.dart';

class RouteMap extends StatefulWidget {
  final MapController controller;

  const RouteMap({Key? key, required this.controller}) : super(key: key);

  @override
  State<RouteMap> createState() => _RouteMapState();
}

class _RouteMapState extends State<RouteMap> {
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  late final MapOptions options;
  late LatLng pointerUp;

  late final BuilderBloc bloc;
  List<LatLng> positions = [];
  List<Place> places = [];
  List<Marker> markers = [];

  // final List<Marker> _markers = [];
  final Polyline route = Polyline(
    color: primaryColor,
    strokeWidth: 5.0,
    strokeCap: StrokeCap.square,
    borderColor: primaryColor,
    borderStrokeWidth: 3.0,
    points: [],
  );

  @override
  void initState() {
    super.initState();

    bloc = context.read();

    // Map setup
    options = MapOptions(
      // TODO: Get user location if creating a new tour
      // center: positions.first,
      zoom: 18.0,
      interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
      keepAlive: true,
      onTap: _onMapTap,
      onPointerUp: (event, point) => pointerUp = point,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Position>(
      stream: Geolocator.getPositionStream(locationSettings: locationSettings),
      builder: (context, snapshot) {
        return BlocBuilder<BuilderBloc, BuilderState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is BuilderEditing) {
              final Tour tour = state.tour;
              places = tour.places;
              markers = _getMarkers(places);

              return DragTarget<int>(
                onAccept: (data) {
                  markers[data].point.latitude = pointerUp.latitude;
                  markers[data].point.longitude = pointerUp.longitude;
                },
                builder: (context, candidateData, rejectedData) => FlutterMap(
                  mapController: widget.controller,
                  options: options,
                  children: [
                    _buildTile(),
                    _buildPath(places),
                    _buildMarkers(markers),
                    _buildUser(snapshot.data),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        );
      },
    );
  }

  void _onMapTap(TapPosition tapPosition, LatLng latLng) {
    _showEditor(key: places.length, location: latLng);
  }

  Widget _buildPath(List places) {
    final Polyline polyline = Polyline(
      points: [],
      color: primaryTextColor,
      strokeWidth: 6.0,
      // isDotted: true,
      // useStrokeWidthInMeter: true,
    );
    for (var p in places) {
      polyline.points.add(p.location);
    }

    return PolylineLayer(polylines: [polyline]);
  }

  List<Marker> _getMarkers(List places) {
    final List<Marker> markers = [];

    places.asMap().forEach((key, place) {
      markers.add(_buildMarker(key, (place as Place).location!));
    });

    return markers;
  }

  // TODO: Separate marker
  Marker _buildMarker(int key, LatLng latLng) {
    return Marker(
      key: ValueKey(key),
      point: latLng,
      builder: (context) => LongPressDraggable<int>(
        data: key,
        feedback: Transform.scale(
          scale: 1.5,
          child: const Icon(
            Icons.circle_rounded,
            shadows: [
              Shadow(
                color: Colors.black54,
                blurRadius: 4,
                offset: Offset(0, 1),
              )
            ],
            color: primaryColor,
          ),
        ),
        childWhenDragging: Icon(
          Icons.circle_rounded,
          shadows: const [
            Shadow(
              color: Colors.black54,
              blurRadius: 4,
              offset: Offset(0, 1),
            )
          ],
          color: primaryColor.withOpacity(0.6),
        ),
        child: InkWell(
          onTap: () {
            _editPoint(key);
          },
          child: const Icon(
            Icons.circle_rounded,
            shadows: [
              Shadow(
                color: Colors.black54,
                blurRadius: 4,
                offset: Offset(0, 1),
              )
            ],
            color: primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildMarkers(List<Marker> markers) {
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

  void _editPoint(int key) {
    _showEditor(key: key);
  }

  void _showEditor({required int key, LatLng? location}) {
    Place place =
        places.elementAtOrNull(key) ?? Place(key: key, location: location);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      builder: (context) => BlocProvider<BuilderBloc>.value(
        value: bloc,
        child: PlaceEditSheet(place: place),
      ),
    );
  }
}
