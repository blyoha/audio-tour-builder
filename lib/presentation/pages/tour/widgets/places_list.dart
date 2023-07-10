import 'package:flutter/material.dart';

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
    return ListTile(
      title: Text(place.title!),
      leading: _icon(),
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
  }

  Widget _icon() {
    return const Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          Icons.circle_rounded,
          size: 28.0,
          color: primaryColor,
        ),
        Icon(
          Icons.circle_rounded,
          size: 14.0,
          color: primaryTextColor,
        ),
      ],
    );
  }
}
