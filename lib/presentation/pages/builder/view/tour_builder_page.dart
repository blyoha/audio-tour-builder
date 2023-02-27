import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/tours/tours.dart';
import '../../../../repositories/models/models.dart';
import '../../../../routes.dart' as routes;
import 'map_page.dart';
import 'tour_details_page.dart';

class TourBuilderPage extends StatefulWidget {
  static const String route = '/tourBuilder';

  const TourBuilderPage({Key? key}) : super(key: key);

  @override
  State<TourBuilderPage> createState() => _TourBuilderPageState();
}

class _TourBuilderPageState extends State<TourBuilderPage> {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  late ToursBloc bloc;
  late Tour tour;

  @override
  void initState() {
    super.initState();
    bloc = context.read();
  }

  @override
  Widget build(BuildContext context) {
    final prevRoute = ModalRoute.of(context)!.settings.arguments as String;

    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        if (state is ToursTourLoaded) tour = state.tour;
        titleController.text = tour.title;
        descController.text = tour.description;

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Create a tour'),
              bottom: const TabBar(tabs: [
                Tab(child: Text('Details')),
                Tab(child: Text('Map')),
              ]),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_outlined),
                onPressed: () async {
                  print(prevRoute);
                  if (state is ToursTourLoaded) {
                    bloc.add(prevRoute == routes.homePage
                      ? ToursLoadAll()
                      : ToursLoadTour(tour: state.tour));
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
                  tour = tour.copyWith(
                    title: titleController.text,
                    description: descController.text,
                  );

                  bloc.add(ToursSaveTour(tour: tour));
                  Navigator.pop(context);
                }
              },
              label: const Text('Save Tour'),
            ),
            body: TabBarView(
              children: [
                TourDetailsPage(
                  titleController: titleController,
                  descController: descController,
                ),
                const MapPage(),
              ],
            ),
          ),
        );
      },
    );
  }
}
