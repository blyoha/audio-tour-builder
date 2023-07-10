import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/routing/routing_bloc.dart';
import '../../../../repositories/models/place.dart';
import '../../../../theme/theme_constants.dart';
import 'place_info_sheet.dart';

class PlaceMarker extends StatelessWidget {
  final Place place;

  const PlaceMarker({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RoutingBloc bloc = context.read<RoutingBloc>();

    return BlocBuilder<RoutingBloc, RoutingState>(
      bloc: bloc,
      builder: (context, state) {
        final int currentPlaceId = bloc.currentPlace();
        final color = currentPlaceId == place.key ? primaryColor : Colors.red;
        final scale = currentPlaceId == place.key ? 1.5 : 1.0;

        return GestureDetector(
          onTap: () => showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            builder: (context) => PlaceInfoSheet(
              title: place.title!,
              description: place.description!,
              images: place.images!,
            ),
          ),
          child: Transform.scale(
            scale: scale,
            child: Icon(
              Icons.circle_rounded,
              shadows: const [
                Shadow(
                  color: Colors.black54,
                  blurRadius: 4,
                  offset: Offset(0, 1),
                )
              ],
              color: color,
            ),
          ),
        );
      },
    );
  }
}
