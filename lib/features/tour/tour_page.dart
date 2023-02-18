import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../common/utils/styles.dart';
import '../tour_builder/pages/tour_builder_page.dart';
import '../tours/tour.dart';

class TourPage extends StatelessWidget {
  final Tour tour;

  const TourPage({Key? key, required this.tour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              'assets/images/test_image.png',
              height: 250,
              fit: BoxFit.fitHeight,
            ),
          ),
          const Gap(12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: MaterialButton(
                        color: AppColors.primary,
                        onPressed: () {},
                        child: const Text('Start tour'),
                      ),
                    ),
                    const Gap(10),
                    MaterialButton(
                      color: Colors.white70,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TourBuilderPage(tour: tour),
                        ));
                      },
                      child: Icon(
                        Icons.edit,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
                _buildDescription(tour.title, tour.description),
                const Divider(height: 1),
                _buildParameters(tour.distance, tour.time, tour.places),
                const Divider(height: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParameters(
    double distance,
    double time,
    List<Place> places,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              const Icon(Icons.route_outlined),
              const Gap(6),
              Text('$distance km'),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.timer_outlined),
              const Gap(6),
              Text('$time h'),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.place_outlined),
              const Gap(6),
              Text('${places?.length ?? 0}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(
    String title,
    String description,
  ) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const Gap(4.0),
          Text(description),
        ],
      ),
    );
  }
}
