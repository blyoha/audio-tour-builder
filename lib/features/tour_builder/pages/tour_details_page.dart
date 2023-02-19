import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../common/utils/styles.dart';
import '../../tours/tour.dart';
import '../bloc/tour_builder_bloc.dart';
import '../bloc/tour_builder_state.dart';

class TourDetailsPage extends StatelessWidget {
  late final Tour tour;
  final titleController = TextEditingController();
  final descController = TextEditingController();

  TourDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: context.read<TourBuilderBloc>(),
      listener: (context, state) {
        if (state is TourBuilderLoaded) {
          tour = state.tour;
          titleController.text = tour.title;
          descController.text = tour.description;
        }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          heroTag: null,
          onPressed: () {
            if (titleController.text.isEmpty | descController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Empty text fields!')),
              );
            } else {
              // bloc.add(TourBuilderSave(tour: tour));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Tour saved.'),
                  duration: Duration(milliseconds: 500),
                ),
              );
            }
          },
          label: const Text('Save Tour'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Tour title', style: AppTextStyles.cardHeader),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: 'Title'),
              ),
              const Gap(10),
              Text('Tour title', style: AppTextStyles.cardHeader),
              TextField(
                maxLines: null,
                controller: descController,
                decoration: const InputDecoration(hintText: 'Description'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
