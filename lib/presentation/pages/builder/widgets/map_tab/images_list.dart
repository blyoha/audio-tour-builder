import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:uuid/uuid.dart';

import '../../../../../blocs/builder/builder_bloc.dart';
import '../../../../../theme/theme_constants.dart';

class ImagesList extends StatefulWidget {
  final List<File> images;

  const ImagesList({Key? key, required this.images}) : super(key: key);

  @override
  State<ImagesList> createState() => _ImagesListState();
}

class _ImagesListState extends State<ImagesList> {
  late final BuilderBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = context.read<BuilderBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text('Images', style: Theme.of(context).textTheme.titleLarge),
        ),
        const Gap(8.0),
        SizedBox(
          height: 100.0,
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: widget.images.length + 1,
            separatorBuilder: (context, index) => const Gap(4.0),
            itemBuilder: (context, index) => GestureDetector(
              child: widget.images.length == index
                  ? _buildAddButton()
                  : _buildImage(context, index),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImage(BuildContext context, int index) {
    var image = File(widget.images[index].path);

    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.9,
          snapSizes: const [0.9],
          snap: true,
          expand: false,
          builder: (context, scrollController) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                const Gap(8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        widget.images.removeAt(index);
                        Navigator.pop(context);
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.delete_outline_rounded,
                        color: errorColor,
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        _pickFile(index: index);
                        Navigator.pop(context);
                      },
                      child: const Text('Edit'),
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.file(image, fit: BoxFit.fitWidth),
                ),
              ],
            ),
          ),
        ),
      ),
      child: Container(
        width: 100.0,
        decoration: BoxDecoration(
          color: primaryTextColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image.file(image, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: () async {
        _pickFile();
      },
      child: Container(
        width: 100.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: primaryTextColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  void _pickFile({int? index}) async {
    FilePickerResult? data = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: index == null,
    );

    if (data != null) {
      for (var f in data.files) {
        File file = File(f.path!);

        // Rename file
        var lastSeparator = file.path.lastIndexOf(Platform.pathSeparator);
        var lastDot = file.path.lastIndexOf('.');
        var path = file.path.substring(0, lastSeparator + 1);
        var type = file.path.substring(lastDot);
        var newPath = '$path${const Uuid().v4()}$type';

        file = await file.rename(newPath);

        if (index != null) {
          widget.images.replaceRange(index, index + 1, [file]);
        } else {
          widget.images.add(file);
        }
        setState(() {});
      }
    } else {
      // user cancelled the picker
    }
  }
}
