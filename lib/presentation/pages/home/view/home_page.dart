import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../blocs/tours/tours.dart';
import '../../../../config/theme.dart';
import '../../../../repositories/models/models.dart';
import '../../../../router.dart';
import '../../../widgets/search_bar_widget.dart';
import '../../tour/tour_page.dart';

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
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            bloc.add(ToursLoadTour(tour: Tour.empty()));
            await Navigator.of(context).pushNamed(
              AppRouter.tourBuilderPage,
              arguments: HomePage.route,
            );
            bloc.add(ToursLoadAll());
          },
          label: const Text('Add'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: _buildPage());
  }

  Widget _buildTourCard(Tour tour) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: Container(
        height: 125,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 6.0,
              spreadRadius: -6,
              color: AppColors.black.withOpacity(.25),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: GestureDetector(
          onTap: () async {
            bloc.add(ToursLoadTour(tour: tour));
            await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const TourPage()));
            bloc.add(ToursLoadAll());
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    tour.title,
                    style: AppTextStyles.cardHeader,
                  ),
                  const Gap(8),
                  Text(
                    tour.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tours'),
        actions: [
          MaterialButton(
            child: const Icon(Icons.refresh_rounded),
            onPressed: () {
              bloc.add(ToursLoadAll());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            const SearchBar(),
            BlocBuilder<ToursBloc, ToursState>(
              builder: (context, state) {
                if (state is ToursLoading) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }
                if (state is ToursAllLoaded) {
                  return Expanded(
                    child: state.tours.isEmpty
                        ? const Center(child: Text('No tours yet!'))
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.tours.length,
                            itemBuilder: (context, index) =>
                                _buildTourCard(state.tours[index]),
                          ),
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
      ),
    );
  }
}
