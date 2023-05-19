import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../blocs/routing/routing_bloc.dart';
import '../../../../repositories/models/place.dart';
import 'places_list.dart';
import 'player.dart';
import 'resize_indicator.dart';

class RouteSheet extends StatefulWidget {
  final List<Place> places;

  const RouteSheet({Key? key, required this.places}) : super(key: key);

  @override
  State<RouteSheet> createState() => _RouteSheetState();
}

class _RouteSheetState extends State<RouteSheet> {
  @override
  Widget build(BuildContext context) {
    final RoutingBloc bloc = context.read();

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
          child: BlocBuilder<RoutingBloc, RoutingState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is RoutingLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                physics: const ClampingScrollPhysics(),
                controller: scrollController,
                child: Column(
                  children: [
                    const ResizeIndicator(),
                    const Player(),
                    const Gap(12.0),
                    PlacesList(places: widget.places),
                    const Gap(12.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            child: const Text("END TOUR"),
                            onPressed: () {
                              bloc.add(RoutingFinish());
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
