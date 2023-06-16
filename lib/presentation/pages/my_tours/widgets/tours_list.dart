import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../repositories/models/models.dart';
import 'tour_card.dart';

class ToursList extends StatelessWidget {
  final List<Tour> tours;

  const ToursList({Key? key, required this.tours}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: tours.length,
      separatorBuilder: (context, index) => const Gap(16.0),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed("tour", arguments: tours[index]);
          },
          child: TourCard(tour: tours[index]),
        );
      },
    );
  }
}
