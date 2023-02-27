import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../blocs/tours/tours.dart';
import '../../../../config/theme.dart';
import '../../../../repositories/models/models.dart';

class MapPage extends StatefulWidget {
  static const String route = 'map';
  final List places;

  const MapPage({Key? key, required this.places}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
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
                      bloc: context.read<ToursBloc>(),
                      builder: (context, state) {
                        if (state is ToursTourLoaded) {
                          return Expanded(
                            child: widget.places.isEmpty
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
                                    itemCount: widget.places.length,
                                    itemBuilder: (context, index) =>
                                        _buildPointItem(
                                            widget.places[index]),
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
                        showDialog(
                          context: context,
                          builder: (context) {
                            final title = TextEditingController();
                            final desc = TextEditingController();
                            return Dialog(
                              insetPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(autofocus: true, controller: title),
                                  TextField(controller: desc),
                                  Row(
                                    children: [
                                      MaterialButton(
                                        child: const Text('Add'),
                                        onPressed: () {
                                          widget.places.add(
                                              Place(
                                                title: title.text,
                                                description: desc.text,
                                              ));
                                          setState(() {});
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      MaterialButton(
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => BlocProvider.value(
                        //       value: bloc,
                        //       child: const PointBuilderPage(),
                        //     ),
                        //   ),
                        // );
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
