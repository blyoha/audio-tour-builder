import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gap/gap.dart';
import 'package:latlong2/latlong.dart';

import '../../../../api_key.dart';
import '../../../../blocs/tours/tours.dart';
import '../../../../config/theme.dart';
import '../../../../repositories/models/models.dart';

class MapPage extends StatefulWidget {
  static const String route = 'map';
  final List<Place> places;

  const MapPage({Key? key, required this.places}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const url = urlTemplate;
  static const apiKey = mapsApiKey;

  MapController? _mapController;
  MapOptions? _options;

  final List<Marker> _markers = [];
  final Polyline _route = Polyline(
    color: AppColors.primary,
    strokeWidth: 5.0,
    strokeCap: StrokeCap.square,
    borderColor: AppColors.black,
    borderStrokeWidth: 3.0,
    points: [],
  );

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _options = MapOptions(
      // TODO: Apply user's current location to the map center
      center: LatLng(45.03585, 38.97431),
      zoom: 16.0,
      maxZoom: 18.0,
      interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
      keepAlive: true,
      onTap: _onMapTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          _buildMap(),
          // _showBottomSheet(),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return BlocBuilder(
      bloc: context.read<ToursBloc>(),
      builder: (context, state) {
        if (state is ToursTourLoaded) {
          _markers.clear();

          widget.places
              .asMap()
              .forEach((key, value) => _addPoint(key, value.location));
        }

        return FlutterMap(
          mapController: _mapController,
          options: _options!,
          children: [
            TileLayer(
              urlTemplate: "$url?api_key={api_key}",
              additionalOptions: const {"api_key": apiKey},
            ),
            PolylineLayer(polylines: [_route]),
            MarkerLayer(markers: _markers),
          ],
        );
      },
    );
  }

  void _addPoint(int key, LatLng latLng) {
    var valueKey = ValueKey(key);
    Marker newMarker = Marker(
      key: valueKey,
      point: latLng,
      builder: (context) =>
          LongPressDraggable<LatLng>(
            data: latLng,
            feedback: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.black, width: 2),
                color: AppColors.primary,
              ),
            ),
            childWhenDragging: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:
                Border.all(color: AppColors.black.withOpacity(.8), width: 2),
                color: AppColors.primary.withOpacity(.8),
              ),
            ),
            child: InkWell(
              onTap: () {
                _editPoint(valueKey);
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.black, width: 2),
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
    );

    _markers.add(newMarker);
    _route.points.clear();
    for (var m in _markers) {
      _route.points.add(m.point);
    }
  }

  void _editPoint(ValueKey key) {
    Place? place;
    late TextEditingController titleCont;
    late TextEditingController descCont;
    File audioFile;

    showDialog(
      context: context,
      builder: (context) {
        return BlocBuilder(
          bloc: context.read<ToursBloc>(),
          builder: (context, state) {
            if (state is ToursTourLoaded) {
              place = widget.places.asMap()[key.value];

              titleCont = TextEditingController(text: place?.title);
              descCont = TextEditingController(text: place?.description);
            }

            return Dialog(
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(autofocus: true, controller: titleCont),
                  TextField(controller: descCont),
                  OutlinedButton(
                    onPressed: () async {
                      FilePickerResult? data = await FilePicker.platform
                          .pickFiles(type: FileType.audio);

                      if (data != null) {
                        audioFile = File(data.files.single.path!);
                      } else {
                        // user cancelled the picker
                      }
                    },
                    child: const Icon(Icons.upload_file),
                  ),
                  Row(
                    children: [
                      MaterialButton(
                        child: const Text('Save'),
                        onPressed: () {
                          widget.places[key.value] = place!.copyWith(
                            title: titleCont.text,
                            description: descCont.text,
                            // audio: audioFile,
                          );

                          Navigator.of(context).pop();
                        },
                      ),
                      MaterialButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future _onMapTap(dynamic tapPosition, dynamic latLng) {
    return showDialog(
      context: context,
      builder: (context) {
        final title = TextEditingController();
        final desc = TextEditingController();
        late final File audioFile;

        return Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(autofocus: true, controller: title),
              TextField(controller: desc),
              OutlinedButton(
                onPressed: () async {
                  FilePickerResult? data =
                  await FilePicker.platform.pickFiles(type: FileType.audio);

                  if (data != null) {
                    audioFile = File(data.files.single.path!);
                  } else {
                    // user cancelled the picker
                  }
                },
                child: const Icon(Icons.upload_file),
              ),
              Row(
                children: [
                  MaterialButton(
                    child: const Text('Add'),
                    onPressed: () {
                      int key = widget.places.length;
                      widget.places.add(Place(
                        title: title.text,
                        description: desc.text,
                        location: latLng,
                        // audio: audioFile,
                      ));

                      _addPoint(key, latLng);

                      if (kDebugMode) {
                        print('Places: ${widget.places}');
                        print('Markers: $_markers');
                        print('Polyline: ${_route.points}');
                      }

                      Navigator.of(context).pop();
                    },
                  ),
                  MaterialButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _showBottomSheet() {
    return DraggableScrollableSheet(
      initialChildSize: 0.2,
      minChildSize: 0.2,
      maxChildSize: 1.0,
      snap: true,
      snapSizes: const [0.55, 1],
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: AppColors.black.withOpacity(0.25),
              )
            ],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Column(
            children: [
              const Gap(8),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.black.withOpacity(.5),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                width: 45,
                height: 6,
              ),
              const Gap(8),
              BlocBuilder(
                bloc: context.read<ToursBloc>(),
                builder: (context, state) {
                  if (state is ToursTourLoaded) {
                    return Expanded(
                      child: widget.places.isEmpty
                          ? const SizedBox(
                        height: 200,
                        child: Text('No places yet!'),
                      )
                          : ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 8.0,
                        ),
                        controller: scrollController,
                        separatorBuilder: (context, index) =>
                        const Gap(6),
                        itemCount: widget.places.length,
                        itemBuilder: (context, index) =>
                            _buildPointItem(widget.places[index]),
                        shrinkWrap: true,
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPointItem(Place place) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 6.0,
            color: AppColors.black.withOpacity(.25),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      child: Row(
        children: [
          Icon(
            Icons.circle_outlined,
            color: AppColors.black,
          ),
          const Gap(10),
          Text(place.title),
        ],
      ),
    );
  }
}
