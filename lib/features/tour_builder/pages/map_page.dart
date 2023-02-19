import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:interview/features/tour_builder/bloc/tour_builder_state.dart';

import '../../../common/utils/styles.dart';
import '../../tours/tour.dart';
import '../bloc/tour_builder_bloc.dart';
import 'point_builder_page.dart';

class MapPage extends StatelessWidget {
  late final Tour tour;

  MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TourBuilderBloc bloc = context.read();

    return Scaffold(
      body: Stack(
        children: [
          DraggableScrollableSheet(
            initialChildSize: 0.55,
            minChildSize: 0.2,
            maxChildSize: 1.0,
            snap: true,
            snapSizes: const [0.55, 1],
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: AppColors.black.withOpacity(0.25),
                    )
                  ],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Column(
                  children: [
                    const Gap(8),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.black.withOpacity(.5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                      ),
                      width: 45,
                      height: 6,
                    ),
                    const Gap(8),
                    BlocBuilder(
                      bloc: context.read<TourBuilderBloc>(),
                      builder: (context, state) {
                        if (state is TourBuilderLoaded) {
                          return Expanded(
                            child: state.tour.places.isEmpty
                                ? const SizedBox(
                                    height: 200,
                                    child: Text('No places yet!'),
                                  )
                                : ListView.separated(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0,
                                      vertical: 8.0,
                                    ),
                                    controller: scrollController,
                                    separatorBuilder: (context, index) =>
                                        const Gap(6),
                                    itemCount: state.tour.places.length,
                                    itemBuilder: (context, index) =>
                                        _buildPointItem(
                                            state.tour.places[index]),
                                    shrinkWrap: true,
                                  ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                    FloatingActionButton.extended(
                      heroTag: null,
                      label: const Text('Add'),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
                              value: bloc,
                              child: const PointBuilderPage(),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPointItem(Place place) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 6.0,
            color: AppColors.black.withOpacity(.25),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      child: Row(
        children: [
          Icon(
            Icons.circle_outlined,
            color: AppColors.black,
          ),
          const Gap(10),
          Text(place.title),
        ],
      ),
    );
  }
}
