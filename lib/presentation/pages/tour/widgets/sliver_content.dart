import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../repositories/models/tour.dart';
import '../../../../repositories/tours_repository.dart';
import '../../../../theme/theme_constants.dart';
import 'places_list.dart';

class SliverContent extends StatefulWidget {
  final Tour tour;

  const SliverContent({Key? key, required this.tour}) : super(key: key);

  @override
  State<SliverContent> createState() => _SliverContentState();
}

class _SliverContentState extends State<SliverContent> {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
      ),
      sliver: SliverList(
        delegate: SliverChildListDelegate(_buildSliverContent(context)),
      ),
    );
  }

  List<Widget> _buildSliverContent(BuildContext context) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.tour.title,
            style: Theme.of(context).textTheme.titleLarge,
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
      const Gap(12.0),
      Text(
        widget.tour.description,
        style: const TextStyle(letterSpacing: 1.2),
      ),
      const Gap(22.0),
      const Divider(height: 1.0, color: secondaryTextColor),
      const Gap(12.0),
      _buildParameters(10, 1.2, [1, 1, 1]),
      const Gap(12.0),
      const Divider(height: 1.0, color: secondaryTextColor),
      const Gap(22.0),
      Text(
        "Tour route",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      const Gap(8.0),
      PlacesList(places: widget.tour.places),
    ];
  }

  Widget _buildParameters(
    double distance,
    double time,
    List places,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            const Icon(Icons.route_outlined),
            const Gap(12.0),
            Text(distance.toString()),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.timer_outlined),
            const Gap(12.0),
            Text(time.toString()),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.place_outlined),
            const Gap(12.0),
            Text(places.length.toString()),
          ],
        ),
      ],
    );
  }
}
