import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:latlong2/latlong.dart';
import 'package:uuid/uuid.dart';

import '../../../../../blocs/builder/builder_bloc.dart';
import '../../../../../repositories/models/place.dart';
import '../../../../../theme/theme_constants.dart';
import '../../../routing/widgets/resize_indicator.dart';
import '../input_frame.dart';

class PlaceEditSheet extends StatefulWidget {
  final Place place;
  final ValueKey? index;
  final LatLng? location;
  final VoidCallback? onPressed;

  const PlaceEditSheet({
    Key? key,
    required this.place,
    this.index,
    this.location,
    this.onPressed,
  }) : super(key: key);

  @override
  State<PlaceEditSheet> createState() => _PlaceEditSheetState();
}

class _PlaceEditSheetState extends State<PlaceEditSheet> {
  final title = TextEditingController();
  final description = TextEditingController();
  File? audioFile;

  @override
  void initState() {
    super.initState();

    title.text = widget.place.title ?? "";
    description.text = widget.place.description ?? "";
    audioFile = widget.place.audio;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BuilderBloc>();

    return BlocBuilder<BuilderBloc, BuilderState>(
      bloc: bloc,
      builder: (context, state) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) => Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    const ResizeIndicator(),
                    Expanded(
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              InputFrame(label: "Title", controller: title),
                              const Gap(12.0),
                              InputFrame(
                                label: "Description",
                                controller: description,
                                expanded: true,
                              ),
                              const Gap(12.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "Audio file",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              _buildFilePicker(),
                              const Gap(12.0),
                              TextButton(
                                onPressed: () {
                                  if (state is BuilderEditing) {
                                    final places = List.of(state.tour.places);

                                    final place = widget.place.copyWith(
                                      title: title.text,
                                      description: description.text,
                                      audio: audioFile,
                                    );

                                    if (places.contains(place)) {
                                      places.replaceRange(
                                          place.key!, place.key! + 1, [place]);
                                    } else {
                                      places.add(place);
                                    }

                                    final tour = state.tour.copyWith(
                                      places: places,
                                    );

                                    bloc.add(BuilderLoad(tour: tour));
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: const Text("Save"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: 0.0,
                  child: IconButton(
                    onPressed: () {
                      if (state is BuilderEditing) {
                        final places = List.of(state.tour.places);
                        places.removeAt(widget.place.key!);

                        final tour = state.tour.copyWith(
                          places: places,
                        );

                        bloc.add(BuilderLoad(tour: tour));
                        Navigator.of(context).pop();
                      }
                    },
                    iconSize: 28.0,
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: errorColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            audioFile != null ? audioFile!.path.toString() : "No audio",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildButton(
              onPressed: () async {
                FilePickerResult? data =
                    await FilePicker.platform.pickFiles(type: FileType.audio);

                if (data != null) {
                  audioFile = File(data.files.single.path!);
                  // TODO: use file name if exists
                  var name = '${const Uuid().v4()}.mp3';
                  var lastSeparator =
                      audioFile!.path.lastIndexOf(Platform.pathSeparator);
                  var newPath =
                      '${audioFile!.path.substring(0, lastSeparator + 1)}$name';
                  audioFile = await audioFile!.rename(newPath);
                } else {
                  // user cancelled the picker
                }

                setState(() {});
              },
              icon: const Icon(Icons.upload_file_outlined),
            ),
            Visibility(
              visible: audioFile != null,
              child: _buildButton(
                onPressed: () async {
                  if (audioFile != null) {
                    await audioFile!.delete();
                    setState(() {});
                  }
                },
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  color: errorColor,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildButton({required VoidCallback onPressed, required Icon icon}) {
    return IconButton.outlined(
      onPressed: onPressed,
      icon: icon,
      iconSize: 26,
    );
  }
}