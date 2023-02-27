import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../blocs/tours/tours.dart';
import '../../../../config/theme.dart';
import '../../../../repositories/models/models.dart';

class TourDetailsPage extends StatelessWidget {
  late Tour tour;
  final titleController = TextEditingController();
  final descController = TextEditingController();

  TourDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ToursBloc>();

    return BlocListener(
      bloc: bloc,
      listener: (context, state) {
        if (state is ToursTourLoaded) {
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
              tour = tour.copyWith(
                title: titleController.text,
                description: descController.text,
              );
              bloc.add(ToursSaveTour(tour: tour));

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Tour saved.'),
                  duration: Duration(milliseconds: 500),
                ),
              );
              Navigator.pop(context);
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
                textInputAction: TextInputAction.next,
                controller: titleController,
                decoration: const InputDecoration(hintText: 'Title'),
              ),
              const Gap(10),
              Text('Tour description', style: AppTextStyles.cardHeader),
              TextField(
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
