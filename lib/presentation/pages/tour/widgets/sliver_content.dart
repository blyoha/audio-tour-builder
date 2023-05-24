import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../repositories/models/place.dart';
import '../../../../repositories/models/tour.dart';
import '../../../../theme/theme_constants.dart';

class SliverContent extends StatelessWidget {
  final Tour tour;

  const SliverContent({Key? key, required this.tour}) : super(key: key);

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

  List<Widget> _buildSliverContent(context) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            tour.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          GestureDetector(
            onTap: () {
              print("add to favourite");
            },
            child: const Icon(
              Icons.favorite_border_outlined,
              size: 32.0,
            ),
          ),
        ],
      ),
      const Gap(12.0),
      Text(
        tour.description,
        style: const TextStyle(letterSpacing: 1.2),
      ),
      const Gap(12.0),
      const Divider(height: 1.0, color: secondaryTextColor),
      const Gap(12.0),
      _buildParameters(10, 1.2, [1, 1, 1]),
      const Gap(12.0),
      const Divider(height: 1.0, color: secondaryTextColor),
      const Gap(12.0),
      Text(
        "Tour route",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      const Gap(8.0),
      PlacesList(places: tour.places),
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

class PlacesList extends StatelessWidget {
  final List<Place> places;

  const PlacesList({Key? key, required this.places}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: backgroundColor,
      ),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: places.length,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => const Gap(8.0),
        itemBuilder: (context, index) => Text(
          places[index].title,
        ),
      ),
    );
  }
}
