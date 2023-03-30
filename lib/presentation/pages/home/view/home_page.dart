import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../blocs/tours/tours.dart';
import '../../../../config/theme.dart';
import '../../../../repositories/models/models.dart';
import '../../../../router.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/tour_list_widget.dart';

class HomePage extends StatefulWidget {
  static const String route = 'home';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ToursBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read();
    bloc.add(ToursLoadAll());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Tours'),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            bloc.add(ToursLoadTour(tour: Tour.empty()));
            await Navigator.of(context).pushNamed(
              AppRouter.tourBuilderPage,
              arguments: HomePage.route,
            );
          },
          label: const Text('Add'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              const SearchBarWidget(),
              BlocBuilder<ToursBloc, ToursState>(
                bloc: bloc,
                builder: (context, state) {
                  if (state is ToursLoading) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child:
                          CircularProgressIndicator(color: AppColors.primary),
                    );
                  }
                  if (state is ToursAllLoaded) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        bloc.add(ToursLoadAll());
                      },
                      child: TourListWidget(tourList: state.tours),
                    );
                  }
                  if (state is ToursError) {
                    return Center(
                      child: Column(
                        children: [
                          const Text('Loading error!'),
                          const Gap(5),
                          Text(state.error),
                        ],
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ));
  }
}
