import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/routing/routing_bloc.dart';
import '../../../../repositories/location_repository.dart';
import '../../../../repositories/models/tour.dart';
import '../../../../theme/theme_constants.dart';
import '../../routing/view/routing_page.dart';
import '../widgets/sliver_content.dart';

class TourPage extends StatelessWidget {
  static const String route = 'tour';

  final Tour tour;

  const TourPage({Key? key, required this.tour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "start",
        label: const Text("Start Tour"),
        onPressed: () {
          final route = MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => RoutingBloc(
                places: tour.places,
                locationRepo: LocationRepository(),
              ),
              child: RoutingPage(tour: tour),
            ),
          );

          Navigator.of(context).push(route);
        },
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                  color: Colors.white,
                ),
                child: const SizedBox(height: 18),
              ),
            ),
            stretch: true,
            expandedHeight: 200.0,
            flexibleSpace: _showImage(context, tour.imageUrl),
          ),
          SliverContent(tour: tour),
        ],
      ),
    );
  }

  Widget _showImage(BuildContext context, String? image) {
    if (image == null) {
      return Center(
          child: Image.asset(
        "assets/images/no-image.png",
        color: secondaryTextColor,
      ));
    }
    return FlexibleSpaceBar(
      stretchModes: const [StretchMode.zoomBackground],
      background: Image(
        image: AssetImage(image),
        height: 200.0,
        fit: BoxFit.cover,
      ),
    );
  }
}
