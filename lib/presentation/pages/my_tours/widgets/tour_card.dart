import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../repositories/models/tour.dart';
import '../../../../theme/theme_constants.dart';

class TourCard extends StatelessWidget {
  final Tour tour;

  const TourCard({Key? key, required this.tour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 12.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      height: 120.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tour.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22.0,
                ),
              ),
              InkWell(
                child: const Icon(Icons.favorite_border_outlined, size: 32.0),
                onTap: () {},
              ),
            ],
          ),
          const Gap(8.0),
          Text(
            tour.description,
            style: const TextStyle(
              color: secondaryTextColor,
              fontSize: 16.0,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}
