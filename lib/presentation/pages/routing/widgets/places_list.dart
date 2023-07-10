import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/routing/routing_bloc.dart';
import '../../../../repositories/models/place.dart';
import '../../../../theme/theme_constants.dart';
import 'place_info_sheet.dart';

class PlacesList extends StatefulWidget {
  final List<Place> places;

  const PlacesList({
    Key? key,
    required this.places,
  }) : super(key: key);

  @override
  State<PlacesList> createState() => _PlacesListState();
}

class _PlacesListState extends State<PlacesList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: widget.places.length,
        itemBuilder: (context, index) {
          return PlaceTile(place: widget.places[index]);
        },
        separatorBuilder: (context, index) => Divider(
          height: 1,
          color: primaryTextColor.withOpacity(0.3),
        ),
      ),
    );
  }
}

class PlaceTile extends StatelessWidget {
  final Place place;

  const PlaceTile({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RoutingBloc>();

    return BlocBuilder<RoutingBloc, RoutingState>(
      bloc: bloc,
      builder: (context, state) {
        final int currentPlaceId = bloc.currentPlace();
        final icon = _icon(currentPlaceId == place.key);

        return ListTile(
          title: Text(place.title!),
          leading: icon,
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
        );
      },
    );
  }

  Widget _icon(bool active) {
    final Color color = active ? primaryColor : primaryColor.withOpacity(0.3);

    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          Icons.circle_rounded,
          size: 28.0,
          color: color,
        ),
        const Icon(
          Icons.circle_rounded,
          size: 14.0,
          color: primaryTextColor,
        ),
      ],
    );
  }
}
