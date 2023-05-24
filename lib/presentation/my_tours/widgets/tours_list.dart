import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:latlong2/latlong.dart';

import '../../../repositories/models/models.dart';
import '../../pages/tour/view/tour_page.dart';
import 'tour_card.dart';

class ToursList extends StatelessWidget {
  const ToursList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Place> laTour = [
      Place(
        id: 0,
        title: "Place One",
        description: "Place One Description",
        location: LatLng(34.0496, -118.2494),
      ),
      Place(
        id: 1,
        title: "Place Two",
        description: "Place Two Description",
        location: LatLng(34.0502, -118.2488),
      ),
      Place(
        id: 2,
        title: "Place Three",
        description: "Place Three Description",
        location: LatLng(34.0507, -118.2483),
      ),
    ];

    return ListView.separated(
      itemCount: 10,
      separatorBuilder: (context, index) => const Gap(16.0),
      itemBuilder: (context, index) {
        final tour = Tour(
          title: "Tour Title",
          description: "Tour Description " * 20,
          places: laTour,
          distance: 0.0,
          time: 0.0,
        );
        return GestureDetector(
          onTap: () {
            print("go to tour page");
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => TourPage(tour: tour)));
          },
          child: TourCard(tour: tour),
        );
      },
    );
  }
}
