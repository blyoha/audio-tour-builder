import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../theme/theme_constants.dart';
import '../input_frame.dart';

class DetailsTab extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController descController;
  final TextEditingController coverController;

  const DetailsTab({
    Key? key,
    required this.titleController,
    required this.descController,
    required this.coverController,
  }) : super(key: key);

  @override
  State<DetailsTab> createState() => _DetailsTabState();
}

class _DetailsTabState extends State<DetailsTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 12.0,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputFrame(
              label: "Title",
              controller: widget.titleController,
            ),
            const Gap(16.0),
            InputFrame(
              label: "Description",
              controller: widget.descController,
              expanded: true,
            ),
            const Gap(16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Cover image',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const Gap(8.0),
                GestureDetector(
                  onTap: () {
                    _pickFile();
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      height: 180.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: primaryTextColor.withOpacity(0.1),
                      ),
                      child: widget.coverController.text.isEmpty
                          ? const Icon(Icons.mode_edit_outline_outlined)
                          : Image.file(
                              File(widget.coverController.text),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 120.0),
          ],
        ),
      ),
    );
  }

  void _pickFile() async {
    FilePickerResult? data =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (data != null) {
      File file = File(data.files.single.path!);

      widget.coverController.text = file.path;
      setState(() {});
    } else {
      // user cancelled the picker
    }
  }
}
