import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'input_field.dart';

class InputFrame extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool expanded;

  const InputFrame({
    Key? key,
    required this.label,
    required this.controller,
    this.expanded = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const Gap(8.0),
        expanded
            ? InputField(controller: controller, lines: 15)
            : InputField(controller: controller),
      ],
    );
  }
}
