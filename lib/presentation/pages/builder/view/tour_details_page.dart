import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../blocs/tours/tours.dart';
import '../../../../config/theme.dart';
import '../../../../repositories/models/models.dart';

class TourDetailsPage extends StatefulWidget {
  static const String route = 'tourDetails';

  final TextEditingController titleController;
  final TextEditingController descController;

  const TourDetailsPage({
    Key? key,
    required this.titleController,
    required this.descController,
  }) : super(key: key);

  @override
  State<TourDetailsPage> createState() => _TourDetailsPageState();
}

class _TourDetailsPageState extends State<TourDetailsPage> {
  late Tour tour;
  late ToursBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              controller: widget.titleController,
              decoration: const InputDecoration(hintText: 'Title'),
            ),
            const Gap(10),
            Text('Tour description', style: AppTextStyles.cardHeader),
            TextField(
              controller: widget.descController,
              decoration: const InputDecoration(hintText: 'Description'),
            ),
          ],
        ),
      ),
    );
  }
}
