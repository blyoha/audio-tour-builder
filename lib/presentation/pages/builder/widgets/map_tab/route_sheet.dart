import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../blocs/builder/builder_bloc.dart';
import '../../../../../repositories/models/tour.dart';
import '../../../routing/widgets/resize_indicator.dart';
import 'places_list.dart';

class RouteSheet extends StatefulWidget {
  const RouteSheet({Key? key}) : super(key: key);

  @override
  State<RouteSheet> createState() => _RouteSheetState();
}

class _RouteSheetState extends State<RouteSheet> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BuilderBloc>();

    return DraggableScrollableSheet(
      minChildSize: 0.2,
      maxChildSize: 0.8,
      initialChildSize: 0.2,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0)),
            color: Colors.white,
          ),
          child: BlocBuilder<BuilderBloc, BuilderState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is BuilderLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is BuilderEditing) {
                Tour tour = state.tour;

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  physics: const ClampingScrollPhysics(),
                  controller: scrollController,
                  child: Column(
                    children: [
                      const ResizeIndicator(),
                      const Gap(12.0),
                      BlocProvider<BuilderBloc>.value(
                        value: bloc,
                        child: PlacesList(places: tour.places),
                      ),
                      const Gap(12.0),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        );
      },
    );
  }
}
