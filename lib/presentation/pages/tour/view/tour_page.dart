import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../blocs/routing/routing_bloc.dart';
import '../../../../repositories/location_repository.dart';
import '../../../../repositories/models/tour.dart';
import '../../../../repositories/tours_repository.dart';
import '../../../../theme/theme_constants.dart';
import '../../routing/view/routing_page.dart';
import '../widgets/sliver_content.dart';

class TourPage extends StatefulWidget {
  static const String route = 'tour';

  final Tour tour;

  const TourPage({Key? key, required this.tour}) : super(key: key);

  @override
  State<TourPage> createState() => _TourPageState();
}

class _TourPageState extends State<TourPage> {
  bool owned = false;

  @override
  void initState() {
    super.initState();

    _checkOwner().then((value) => owned = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "start",
        label: const Text("Start Tour"),
        onPressed: () {
          final route = MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => RoutingBloc(
                places: widget.tour.places,
                locationRepo: LocationRepository(),
              ),
              child: RoutingPage(tour: widget.tour),
            ),
          );

          Navigator.of(context).push(route);
        },
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: owned ? _buildActions(context) : null,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                  color: Colors.white,
                ),
                child: const SizedBox(height: 18),
              ),
            ),
            stretch: true,
            expandedHeight: 200.0,
            flexibleSpace: _showImage(context, widget.tour.imageUrl),
          ),
          SliverContent(tour: widget.tour),
        ],
      ),
    );
  }

  List<Widget> _buildActions(context) {
    return [
      IconButton(
        onPressed: () => Navigator.pushNamed(
          context,
          'builder',
          arguments: widget.tour,
        ),
        icon: const Icon(Icons.mode_edit_outline_outlined),
      ),
      IconButton(
        onPressed: () async => _showDialog(),
        icon: const Icon(Icons.delete_outline_rounded, color: errorColor),
      ),
    ];
  }

  Widget _showImage(BuildContext context, String? image) {
    if (image == null) {
      return Center(
          child: Image.asset(
        "assets/images/no-image.png",
        color: secondaryTextColor,
      ));
    }
    return FlexibleSpaceBar(
      stretchModes: const [StretchMode.zoomBackground],
      background: Image.network(
        image,
        height: 200.0,
        fit: BoxFit.cover,
      ),
    );
  }

  Future<bool> _checkOwner() async {
    var result = await ToursRepository().owned(widget.tour);
    setState(() {});
    return result;
  }

  _showDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Do you want to delete the tour?',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const Gap(8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      final repo = ToursRepository();
                      await repo
                          .deleteTour(widget.tour)
                          .then((value) => Navigator.pop(context))
                          .then((value) => Navigator.pop(context));
                    },
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: errorColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
