import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'resize_indicator.dart';

class PlaceInfoSheet extends StatelessWidget {
  final String title;
  final String description;

  const PlaceInfoSheet({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 8.0,
      ),
      child: Column(
        children: [
          const ResizeIndicator(),
          Expanded(
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleLarge),
                    const Gap(8.0),
                    Text(description),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
