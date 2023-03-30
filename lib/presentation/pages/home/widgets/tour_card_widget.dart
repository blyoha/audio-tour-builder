import 'package:audioTourBuilder/blocs/tours/tours.dart';
import 'package:audioTourBuilder/repositories/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../config/theme.dart';
import '../../tour/tour_page.dart';

class TourCardWidget extends StatefulWidget {
  final Tour tour;

  const TourCardWidget({Key? key, required this.tour}) : super(key: key);

  @override
  State<TourCardWidget> createState() => _TourCardWidgetState();
}

class _TourCardWidgetState extends State<TourCardWidget> {
  late ToursBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read();
  }

  @override
  Widget build(BuildContext context) {
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
            bloc.add(ToursLoadTour(tour: widget.tour));
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
                    widget.tour.title,
                    style: AppTextStyles.cardHeader,
                  ),
                  const Gap(8),
                  Text(
                    widget.tour.description,
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
}
