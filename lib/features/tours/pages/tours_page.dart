import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../common/utils/styles.dart';
import '../../../common/widgets/search_bar_widget.dart';
import '../../tour/tour_page.dart';
import '../../tour_builder/pages/tour_builder_page.dart';
import '../bloc/tours_bloc.dart';
import '../bloc/tours_event.dart';
import '../bloc/tours_state.dart';
import '../tour.dart';

class ToursPage extends StatefulWidget {
  const ToursPage({Key? key}) : super(key: key);

  @override
  State<ToursPage> createState() => _ToursPageState();
}

class _ToursPageState extends State<ToursPage> {
  final ToursBloc bloc = ToursBloc();

  @override
  void initState() {
    super.initState();
    bloc.add(ToursLoad());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const TourBuilderPage(),
              ));
            },
            label: const Text('Add'),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          body: _buildPage()),
    );
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
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TourPage(tour: tour),
          )),
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
                if (state is ToursLoaded) {
                  return Expanded(
                    child: ListView.builder(
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
