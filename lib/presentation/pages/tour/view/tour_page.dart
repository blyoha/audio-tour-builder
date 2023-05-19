import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../blocs/tours/tours.dart';
import '../../../config/theme.dart';
import '../../../repositories/models/models.dart';
import '../builder/view/view.dart';

class TourPage extends StatefulWidget {
  static const String route = 'tour';

  const TourPage({Key? key}) : super(key: key);

  @override
  State<TourPage> createState() => _TourPageState();
}

class _TourPageState extends State<TourPage> {
  late ToursBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if (state is ToursTourLoaded) {
            String title = state.tour.title;
            String description = state.tour.description;

            return Column(
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
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
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
                              await Navigator.of(context).pushNamed(
                                BuilderPage.route,
                                arguments: TourPage.route,
                              );
                              // Navigator.of(context).push(MaterialPageRoute(
                              //   builder: (context) => const TourBuilderPage(),
                              // ));
                              // bloc.add(ToursLoadTour(tour: ));
                            },
                            child: Icon(
                              Icons.edit,
                              color: AppColors.primary,
                            ),
                          ),
                          MaterialButton(
                            color: Colors.white70,
                            onPressed: () {
                              bloc.add(ToursDeleteTour(tour: state.tour));
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.delete,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      _buildDescription(title, description),
                      const Divider(height: 1),
                      _buildParameters(
                        state.tour.distance,
                        state.tour.time,
                        state.tour.places,
                      ),
                      const Divider(height: 1),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return CircularProgressIndicator(color: AppColors.primary);
          }
        },
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
              color: AppColors.primary,
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
