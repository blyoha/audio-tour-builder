import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/tours/tours.dart';
import '../../../../repositories/models/models.dart';
import '../../../../router.dart';
import 'map_page.dart';
import 'details_page.dart';

class BuilderPage extends StatefulWidget {
  static const String route = 'builder';

  const BuilderPage({Key? key}) : super(key: key);

  @override
  State<BuilderPage> createState() => _BuilderPageState();
}

class _BuilderPageState extends State<BuilderPage> {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  late ToursBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read();
  }

  @override
  Widget build(BuildContext context) {
    final prevRoute = ModalRoute.of(context)!.settings.arguments as String;
    late List<Place> places;
    late Tour newTour;

    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        if (state is ToursTourLoaded) {
          newTour = state.tour.copyWith();
          places = List.from(newTour.places);
        }
        titleController.text = newTour.title;
        descController.text = newTour.description;

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Create a tour'),
              bottom: const TabBar(tabs: [
                Tab(child: Text('Details')),
                Tab(child: Text('Map')),
              ]),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_outlined),
                onPressed: () async {
                  if (state is ToursTourLoaded) {
                    bloc.add(ToursLoadTour(tour: state.tour));
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              heroTag: 'save',
              onPressed: () {
                if (titleController.text.isEmpty |
                    descController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Empty text fields!')),
                  );
                } else {
                  newTour = newTour.copyWith(
                    title: titleController.text,
                    description: descController.text,
                    places: places,
                  );
                  bloc.add(ToursSaveTour(tour: newTour));
                  Navigator.pop(context);
                  bloc.add(prevRoute == AppRouter.homePage
                      ? ToursLoadAll()
                      : ToursLoadTour(tour: newTour));
                }
              },
              label: const Text('Save Tour'),
            ),
            body: TabBarView(
              children: [
                DetailsPage(
                  titleController: titleController,
                  descController: descController,
                ),
                MapPage(places: places),
              ],
            ),
          ),
        );
      },
    );
  }
}