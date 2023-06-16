import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../../blocs/builder/builder_bloc.dart';
import 'route_map.dart';
import 'route_sheet.dart';

class MapTab extends StatefulWidget {
  const MapTab({Key? key}) : super(key: key);

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  final MapController _mapController = MapController();

  late final BuilderBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read();
    askPermission();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Stack(
        children: [
          RouteMap(controller: _mapController),
          const RouteSheet(),
          Positioned(
            right: 10.0,
            top: 10.0,
            child: FloatingActionButton.small(
              heroTag: "currentPosition",
              child: const Icon(Icons.my_location_outlined),
              onPressed: () async {
                final pos = await bloc.currentPosition();
                if (pos != null) {
                  _mapController.move(pos, 18.0);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMap() {
    // TODO: Implement _buildMap
    throw UnimplementedError();
  }

  Widget _buildBottomSheet() {
    // TODO: Implement _buildMap
    throw UnimplementedError();
  }

  _getCenter() {
    // TODO: Get first place position if exists
    return bloc.currentPosition();
  }

  void askPermission() async {
    // LocationPermission permission = await Geolocator.checkPermission();
    LocationPermission permission = await Geolocator.requestPermission();
  }
}
