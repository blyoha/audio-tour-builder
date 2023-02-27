import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:interview/blocs/tours/tours.dart';

import '../../../config/theme.dart';
import '../../../repositories/models/models.dart';
import '../builder/view/view.dart';

class TourPage extends StatefulWidget {
  final Tour tour;

  const TourPage({Key? key, required this.tour}) : super(key: key);

  @override
  State<TourPage> createState() => _TourPageState();
}

class _TourPageState extends State<TourPage> {
  @override
  Widget build(BuildContext context) {
    final ToursBloc bloc = context.read();
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
                      onPressed: () async {
                        await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              TourBuilderPage(tour: widget.tour),
                        ));
                      },
                      child: Icon(
                        Icons.edit,
                        color: AppColors.black,
                      ),
                    ),
                    MaterialButton(
                      color: Colors.white70,
                      onPressed: () {
                        context
                            .read<ToursBloc>()
                            .add(ToursDeleteTour(tour: widget.tour));
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.delete,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
                BlocBuilder(
                  bloc: bloc,
                  builder: (context, state) {
                    String title = "unknown";
                    String description = "unknown";
                    if (state is ToursTourLoaded) {
                      title = state.tour.title;
                      description = state.tour.description;
                    }
                    return _buildDescription(title, description);
                  },
                ),
                const Divider(height: 1),
                _buildParameters(
                    widget.tour.distance, widget.tour.time, widget.tour.places),
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
              Text('${places.length}'),
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
