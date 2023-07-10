import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../repositories/models/tour.dart';
import '../../../../repositories/tours_repository.dart';
import '../../../../theme/theme_constants.dart';

class TourCard extends StatefulWidget {
  final Tour tour;

  const TourCard({Key? key, required this.tour}) : super(key: key);

  @override
  State<TourCard> createState() => _TourCardState();
}

class _TourCardState extends State<TourCard> {
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
      height: 130.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.tour.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22.0,
                ),
              ),
              InkWell(
                child: widget.tour.isLiked
                    ? const Icon(
                  Icons.favorite_outlined,
                  color: Colors.redAccent,
                  size: 32.0,
                )
                    : const Icon(
                  Icons.favorite_border_outlined,
                  size: 32.0,
                ),
                onTap: () async {
                  await context.read<ToursRepository>().toggleLike(widget.tour);
                  setState(() {});
                },
              ),
            ],
          ),
          const Gap(8.0),
          Text(
            widget.tour.description,
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
