import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'input_frame.dart';

class DetailsTab extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descController;

  const DetailsTab({
    Key? key,
    required this.titleController,
    required this.descController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 12.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputFrame(
            label: "Title",
            controller: titleController,
          ),
          const Gap(16.0),
          InputFrame(
            label: "Description",
            controller: descController,
            expanded: true,
          ),
        ],
      ),
    );
  }
}
