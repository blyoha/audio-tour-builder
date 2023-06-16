import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../blocs/builder/builder_bloc.dart';
import '../../../../../repositories/models/place.dart';
import '../../../../../theme/theme_constants.dart';
import 'place_edit_sheet.dart';

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
  late final BuilderBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read();
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
          return BlocProvider<BuilderBloc>.value(
            value: context.read(),
            child: PlaceTile(place: widget.places[index]),
          );
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
      trailing: const Icon(
        Icons.drag_handle_rounded,
        color: secondaryTextColor,
      ),
      onTap: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        builder: (context) => PlaceEditSheet(place: place),
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
