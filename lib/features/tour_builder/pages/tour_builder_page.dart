import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../tours/tour.dart';
import '../bloc/tour_builder_bloc.dart';
import '../bloc/tour_builder_event.dart';
import 'map_page.dart';
import 'tour_details_page.dart';

class TourBuilderPage extends StatelessWidget {
  final Tour? tour;

  const TourBuilderPage({Key? key, this.tour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TourBuilderBloc bloc = TourBuilderBloc()
      ..add(TourBuilderLoad(tour: tour));

    return BlocProvider.value(
      value: bloc,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Create a tour'),
            bottom: const TabBar(tabs: [
              Tab(child: Text('Details')),
              Tab(child: Text('Map')),
            ]),
          ),
          body: TabBarView(
            children: [
              TourDetailsPage(),
              MapPage(),
            ],
          ),
        ),
      ),
    );
  }
}
